{ config, lib, pkgs, ... }:

# Stefan: compared to the default logstash.nix nixos module this module supports multiple pipelines

with lib;

let
  cfg = config.services.logstash-module;
  atLeast54 = versionAtLeast (builtins.parseDrvName cfg.package.name).version "5.4";
  pluginPath = lib.concatStringsSep ":" cfg.plugins;
  havePluginPath = lib.length cfg.plugins > 0;
  ops = lib.optionalString;
  verbosityFlag =
    if atLeast54
    then "--log.level " + cfg.logLevel
    else {
      debug = "--debug";
      info  = "--verbose";
      warn  = ""; # intentionally empty
      error = "--quiet";
      fatal = "--silent";
    }."${cfg.logLevel}";

  pluginsPath =
    if atLeast54
    then "--path.plugins ${pluginPath}"
    else "--pluginpath ${pluginPath}";

  logstashConf = pkgs.writeText "logstash.conf" ''
    input {
      ${cfg.inputConfig}
    }

    filter {
      ${cfg.filterConfig}
    }

    output {
      ${cfg.outputConfig}
    }
  '';

  logstashSettingsYml = pkgs.writeText "logstash.yml" cfg.extraSettings;

  logstashPipelinesYml = pkgs.writeText "pipelines.yml" (
      lib.concatStringsSep "\n" (map (pipe:
      ''
      - pipeline.id: ${pipe.id}
        path.config: ${pkgs.writeText "logstash.conf" pipe.config}
        pipeline.workers: ${toString pipe.workers}
      '')
      cfg.pipes));

  logstashSettingsDir = pkgs.runCommand "logstash-settings" {inherit logstashSettingsYml logstashPipelinesYml;} ''
    mkdir -p $out
    ln -s $logstashSettingsYml $out/logstash.yml
    ln -s $logstashPipelinesYml $out/pipelines.yml
  '';
in

{
  imports = [
  ];

  options = {

    services.logstash-module = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable logstash.";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.logstash6;
        example = literalExample "pkgs.logstash";
        description = "Logstash package to use.";
      };

      plugins = mkOption {
        type = types.listOf types.path;
        default = [ ];
        example = literalExample "[ pkgs.logstash-contrib ]";
        description = "The paths to find other logstash plugins in.";
      };

      dataDir = mkOption {
        type = types.str;
        default = "/var/lib/logstash";
        description = ''
          A path to directory writable by logstash that it uses to store data.
          Plugins will also have access to this path.
        '';
      };

      logLevel = mkOption {
        type = types.enum [ "debug" "info" "warn" "error" "fatal" ];
        default = "warn";
        description = "Logging verbosity level.";
      };

      filterWorkers = mkOption {
        type = types.int;
        default = 1;
        description = "The quantity of filter workers to run.";
      };

      enableWeb = mkOption {
        type = types.bool;
        default = false;
        description = "Enable the logstash web interface.";
      };

      listenAddress = mkOption {
        type = types.str;
        default = "127.0.0.1";
        description = "Address on which to start webserver.";
      };

      port = mkOption {
        type = types.str;
        default = "9292";
        description = "Port on which to start webserver.";
      };

      pipes = mkOption {
        type = with types; listOf (submodule {
            options = {
              id = mkOption {
                type = string;
                description = "Unique name of the pipeline";
              };
              config = mkOption {
                type = lines;
                description = "Config contents of the pipelines's logstash.conf file.";
                example = ''
                input { }
                filter { }
                output { }
                '';
              };
              workers = mkOption {
                type = int;
                default = 1;
                description = "Number of workers for the pipeline";
              };
            };
        });
      };

      extraSettings = mkOption {
        type = types.lines;
        default = "";
        description = "Extra Logstash settings in YAML format.";
        example = ''
          pipeline:
            batch:
              size: 125
              delay: 5
        '';
      };


    };
  };


  ###### implementation

  config = mkIf cfg.enable {
    assertions = [
      { assertion = atLeast54 -> !cfg.enableWeb;
        message = ''
          The logstash web interface is only available for versions older than 5.4.
          So either set services.logstash.enableWeb = false,
          or set services.logstash.package to an older logstash.
        '';
      }
    ];

    systemd.services.logstash = mkOverride 100 (with pkgs; {
      description = "Logstash Daemon";
      wantedBy = [ "multi-user.target" ];
      environment = { JAVA_HOME = jre; };
      path = [ pkgs.bash ];

      script = ''
          # export S3_ACCESS_KEY_ID="$(cat /run/keys/s3-access-key-id)"
          # export S3_SECRET_ACCESS_KEY="$(cat /run/keys/s3-secret-access-key)"
          # export LOGZ_TOKEN="$(cat /run/keys/logz-token)"
          # export AMQ_ASKBY_PWD="$(cat /run/keys/amq-askby-pwd)"
          exec ${cfg.package}/bin/logstash -w ${toString cfg.filterWorkers} ${verbosityFlag} --path.settings ${logstashSettingsDir} --path.data ${cfg.dataDir}
      '';

      serviceConfig = {
        ExecStartPre = ''${pkgs.coreutils}/bin/mkdir -p "${cfg.dataDir}" ; ${pkgs.coreutils}/bin/chmod 700 "${cfg.dataDir}"'';
      };
    });
  };
}
