{ config, lib, pkgs, ... }:

with lib;

{
    imports = [
        # ./defaults.nix
        ./logstash-module.nix
        # ./localredis.nix
    ];

    config =  {

        networking.firewall.allowedTCPPorts = [5044];

        services.logstash-module = {
            enable = true;
            pipes = [
            {
              id = "broker";
              config = ''
              input {
                beats {
                    port => 5044
                    codec => json
                }
              }
              filter {
                  json {
                    source => "message"
                  }
                  # if [logger] == "jsonrpc.backend.flask" {
                  #   mutate { add_field => { "[@metadata][topic]" => "logs.flask" } }
                  # } else {
                  #   mutate { add_field => { "[@metadata][topic]" => "logs.nonflask" } }
                  # }
              }
              output {
                rabbitmq {
                    host => "localhost"
                    user => "stefan"
                    # TODO change to env var
                    password => "foobar"
                    exchange => "logs-topic"
                    exchange_type => "topic"
                    key => "%{[@metadata][topic]}"
                }
              }
              '';
            }
            # {
            #   id = "logz";
            #   config =
            #     let
            #         ca-crt = pkgs.writeText "ca.crt" (lib.readFile ./resources/Logz-io-TrustExternalCARoot.crt);
            #   in
            #    ''
            #   input {
            #     rabbitmq {
            #       host => "localhost"
            #       user => "stefan"
            #       password => "foobar"

            #       exchange => "logs-topic"
            #       exchange_type => "topic"
            #       queue => "logs-logzio-worker"
            #       durable => true

            #       key => "#"
            #     }
            #   }
            #   filter {
            #       mutate {
            #           add_field => { "token" => "''${LOGZ_TOKEN}" }
            #       }
            #   }
            #   output {
            #     lumberjack {
            #       hosts => ["listener.logz.io"]
            #       port => 5006
            #       ssl_certificate => "${ca-crt}"
            #       codec => "json_lines"
            #     }
            #   }
            #   '';
            #  }
            #  {
            #    id = "s3-output";
            #    config = ''
            #    input {
            #     rabbitmq {
            #       host => "localhost"
            #       user => "stefan"
            #       password => "''${AMQ_ASKBY_PWD}"

            #       exchange => "logs-topic"
            #       exchange_type => "topic"
            #       queue => "logs-s3-worker"
            #       durable => true

            #       key => "#"
            #     }
            #    }
            #    output {
            #        s3 {
            #          # user "bot"
            #          access_key_id => "''${S3_ACCESS_KEY_ID}"
            #          secret_access_key => "''${S3_SECRET_ACCESS_KEY}"
            #          region => "eu-central-1"
            #          bucket => "stefan-eu-central"
            #          time_file => 60
            #          codec => "json_lines"
            #          canned_acl => "private"
            #          prefix => "logs/${config.defaults.appEnvironment}/"
            #        }
            #    }
            #    '';
            #  }
            ];
        };
    };
}