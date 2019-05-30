{config, lib, pkgs, ...}:

with lib;

let
    cfg = config.filebeat;
    # ca-crt = pkgs.writeText "ca.crt" (readFile ./resources/COMODORSADomainValidationSecureServerCA.crt);
    filebeat-yml = pkgs.writeTextDir "filebeat.yml" ''
        output.logstash:
          hosts: [${cfg.logstash.host}]

        filebeat.prospectors:
        - type: log
          enabled: true
          paths:
            - /home/stefan/logs/*.json.log
          fields_under_root: true
          encoding: utf-8
          ignore_older: 3h
    '';
in
{
    imports = [ ];

    options.filebeat = {
        logstash = {
            host = mkOption {
                type = types.string;
                example = "host1:234";
                description = "comma-separated list of double-quoted hosts";
            };
        };
    };

    config = {
        systemd.services.filebeat = {
            enable = true;
            description = "filebeat - send logstash files to logstash";
            wantedBy = [ "multi-user.target" ];
            script = ''
            rm -rf /var/filebeat/*
            ${pkgs.filebeat6}/bin/filebeat --path.config=${filebeat-yml} --path.logs=/var/filebeat/logs --path.data=/var/filebeat/data
            '';
        };

        systemd.tmpfiles.rules = [
            "d    /var/filebeat         0755 root root - -"
            "d    /var/filebeat/logs    0755 root root - -"
            "d    /var/filebeat/data    0755 root root - -"
        ];
    };
}
