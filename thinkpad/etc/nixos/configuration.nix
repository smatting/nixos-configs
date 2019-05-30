# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./logstash-logging.nix
      ./filebeat.nix
    ];
  
  filebeat.logstash.host = "localhost";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
      (self: super: {
        nginxCustom = super.nginx.override {
          modules = let m = super.nginxModules;
          in [ m.rtmp
               m.dav
               m.moreheaders
               m.lua
             ];
        };
      })
  ];


  # fileSystems."/home/stefan/askby_files" = {
  #     device = "//files.askby.net/askby_files";
  #     fsType = "cifs";
  #     options = let
  #       # this line prevents hanging on network split
  #       automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #     in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=stefan,gid=users,_netdev"];
  # };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub = {
      efiSupport = true;
      extraEntriesBeforeNixOS = ''
        menuentry "Win10" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --no-floppy --set=root AE8B-C046
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };


  # networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.nameservers = ["213.239.242.238"];
  networking.networkmanager.appendNameservers = ["8.8.8.8"];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    exfat wget vim hello curl wget
  ];

  hardware.pulseaudio.enable = true;
  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

   nix = {
       # buildMachines = [{
       #   hostName = "localhost";
       #   systems = [ "x86_64-linux" ];
       # }];
       trustedUsers = [ "root" "stefan" ];

       # extraOptions = ''
       #   secret-key-files = /home/stefan/test1-secret.txt
       # '';

       binaryCaches = [
           # http://18.185.36.89:8080 # aws build0
          # "http://80.158.35.108:5000" # otc build0
           # http://192.168.1.208:5000 # otc build0
           https://cache.nixos.org/
          "https://hie-nix.cachix.org"
       ];
       binaryCachePublicKeys = [
           "askby-1:fXvc/TFyDlDENEb5U35P+UgLhfpHn6mCYemxtzxtS+k="
           "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
           "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
       ];

       nixPath = [
           "nixpkgs-overlays=/home/stefan/repos/apkgs/overlays"
           "apkgs=/home/stefan/repos/apkgs"
           "ssh-config-file=/nix/store/4vxmfvdj9fl5adw48y5sq5hnxqg25by2-config"
           "nixpkgs=/home/stefan/repos/askby_nixpkgs"
           "nixos-config=/etc/nixos/configuration.nix"
       ];
   };


  # services.hydra = {
  #   enable = false;
  #   hydraURL = "http://localhost";
  #   notificationSender = "stefan@localhost";
  #   buildMachinesFiles = [];
  #   useSubstitutes = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = [ pkgs.gutenprint ];

  services.upower.enable = true;
  services.redis.enable = true;

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbOptions = "compose:caps";
  
    # Enable touchpad support.
    libinput.enable = true;
    libinput.naturalScrolling = true;
  
    # Enable the KDE Desktop Environment.
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
  
      extraPackages = hpkgs: [
  	  hpkgs.taffybar
  	  hpkgs.xmonad-contrib
  	  hpkgs.xmonad-extras
      ];
    };
  };
  
  services.compton.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.stefan = {
    isNormalUser = true;
    home = "/home/stefan";
    description = "Stefan";
    extraGroups = ["wheel" "networkmanager" "input" "docker"];
    shell = pkgs.zsh;
    uid = 1000;
  };

  programs.slock.enable = true;

  networking.firewall.allowedTCPPorts = [5672 15672 8000 80 8303 8080 8888];
  networking.firewall.allowedUDPPorts = [5672 15672 8000 80 8303 8080 8888];
  networking.extraHosts = ''
    127.0.0.1 nginx-lua
    '';

  services.nginx = {
    enable = true;
    # package = pkgs.nginxCustom;
    # package = pkgs.openresty;
    package = pkgs.callPackage ./openresty.nix {};

    appendHttpConfig =
      let
        luapkgs = pkgs.callPackage ./lua.nix {};
      in
    ''
      lua_package_path "${luapkgs.lua-resty-jwt}/lib/?.lua;${luapkgs.lua-resty-string}/lib/?.lua;${luapkgs.lua-resty-hmac}/lib/?.lua;;";
    '';


    virtualHosts = {
      "askby-api" = {
        listen = [{addr = "0.0.0.0"; port = 4000; ssl = false;}];
        locations."/".extraConfig = ''
           proxy_pass http://127.0.0.1:8800;
           proxy_set_header x-askby-customer-name thalia;
           proxy_set_header x-askby-userid 0;
        '';
      };

     "nginx-lua" = {
       listen = [{addr = "0.0.0.0"; port = 80; ssl = false;}];
       locations."/".extraConfig = ''
         default_type 'text/plain';

         # access_by_lua_file /home/stefan/repos/nixos-configs/thinkpad/etc/nixos/access.lua;
         rewrite_by_lua_file /home/stefan/repos/nixos-configs/thinkpad/etc/nixos/rewrite.lua;
         # content_by_lua_file /home/stefan/repos/nixos-configs/thinkpad/etc/nixos/test.lua;

         proxy_set_header Host $http_host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;
         proxy_pass http://127.0.0.1:3000;

         # content_by_lua_block {
         #     ngx.say('Hello,world!')
         # }
       '';
       };
    };


        # enableACME = false;
        # forceSSL = false;
        # root = "/home/stefan/repos/ask-clara/_site";
        # locations."/".extraConfig = ''
        #   add_header Cache-Control no-cache;
        #   expires 1s;
        # '';

  };



  services.rabbitmq = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 5672;
      plugins = ["rabbitmq_management"];
      cookie = "ri4zYzjkyU98WMLQ";
  };

  # NOTE: run this once after creation
  systemd.services.rabbitmq-setup = {
      serviceConfig.Type = "oneshot";
      enable = true;
      script = ''
          cat /var/lib/rabbitmq/.erlang.cookie > /root/.erlang.cookie
          chmod 0600 /root/.erlang.cookie
          export HOME=/root
          export PATH=/run/current-system/sw/bin/:$PATH
          rabbitmqctl add_user stefan foobar
          rabbitmqctl set_user_tags stefan administrator
          rabbitmqctl set_permissions -p / stefan ".*" ".*" ".*"
      '';
  };

  systemd.services.hoogle = {
    enable = true;
    script = ''
      /home/stefan/.nix-profile/bin/hoogle server -p 7777 --local
    '';
    wantedBy = [ "multi-user.target" ];
  };

  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
      job_name = "prometheus";
      static_configs = [{targets = ["localhost:9090"];}];
    }
      {
      job_name = "bibot";
      scrape_interval = "1s";
      static_configs = [{targets = ["localhost:8280"];}];
    }
      {
      job_name = "wtproxy";
      scrape_interval = "1s";
      static_configs = [{targets = ["localhost:8281"];}];
    }
    ];
  };

  services.grafana = {
    enable = true;
    port = 3301;
    # NOTE: this doesn't work afterwards
    # security =  {
    #   adminUser = "askby";
    #   adminPassword = "smtvftlw";
    # };
  };

  # services.autofs = {
  #   enable = true;
  #   autoMaster = 
  #   (let
  #     mapConf = pkgs.writeText "auto" ''
  #      askby_files  -fstype=cifs,credentials=/etc/nixos/smb-secrets,uid=stefan,gid=users //files.askby.net/askby_files
  #     '';
  #    in ''
  #     /auto file:${mapConf}
  #    '');
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

  # systemd.services.backup-askby-files = {
  #     serviceConfig.Type = "oneshot";
  #     script = ''
  #     export AWS_SHARED_CREDENTIALS_FILE="/home/stefan/.aws/s3-credentials";
  #     export PATH=${pkgs.awscli}/bin:$PATH
  #     aws s3 sync /home/stefan/askby/ s3://askby-backup/askby_files
  #     '';
  # };

  # systemd.timers.backup-askby-files = {
  #     partOf = [ "backup-askby-files.service" ];
  #     wantedBy = [ "timers.target" ];
  #     timerConfig = {
  #         OnCalendar = "hourly";
  #     };
  # };

  # systemd.services.foo = {
  #     enable = true;
  #     description = "looker worker";
  #     serviceConfig = {
  #         Restart = "always";
  #         RestartSec = 5;
  #         # ExecStart = "/home/stefan/repos/askby_looker/dist/build/askby-looker/askby-looker";
  #     };
  #     wantedBy = ["multi-user.target"];


  #     # python -c "import sys; while True: import time; time.sleep(1); print('hello')"
  #     # /home/stefan/repos/askby_looker/dist/build/askby-looker/askby-looker
  #     script = ''
  #     export PATH=${pkgs.python3}/bin:$PATH
  #     python3 -c "while True: import time, sys; time.sleep(1); print('hello'); sys.stdout.flush()"
  #     '';
  # };

  services.openvpn.servers = {
      aws = {
          autoStart = true;

          config = ''
          remote 18.195.23.67 1194
          client
          dev tun
          proto udp
          resolv-retry infinite
          nobind
          persist-key
          persist-tun
          remote-cert-tls server
          remote-cert-ku a0

          ;cipher AES-128-CBC
          ;auth SHA256
          comp-lzo
          verb 1

          pkcs12 /home/stefan/.openvpn/stefan.p12

          <tls-auth>
          -----BEGIN OpenVPN Static key V1-----
          5be0a3241fce9547bff5223cdec19868
          17d58ed2a39885b236596355331f596a
          8342ea20ba69fc8d2ac5de06314f04a5
          ce35d88252e3e447c4115a7b3f219208
          08da0ac941e3f0fcb2062ab60dd5f102
          322943c95864e3e149aaf33cb91ce1ee
          ee2835dd47a4ce0a12e175255da63dc4
          712fed6e99d256e52ecbc5b742a328fc
          3c0f79ded5a047df02b32e4e7ceb2c3d
          6ccdbc3ca0ffa474f60ef84f7aae276d
          5985b998e501d75afdb246b01f2dd99c
          7c20d96d9238ed0dacbdfd367421a045
          d6a2a1dde2cf1d910baa7f4f94b637ba
          7540914ec2c443fbbeba747ecba6a667
          5642e07fcd4477b2ac37f2e4e384e4a0
          7209002c4d0fc686437bbd5e7b3fa63e
          -----END OpenVPN Static key V1-----
          </tls-auth>
          '';
      };
  };

  services.postgresql.enable = true;

  fonts.fonts = with pkgs; [
      # noto-fonts
      # noto-fonts-cjk
      # noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts
      dina-font
      proggyfonts
  ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "suspend";
}
