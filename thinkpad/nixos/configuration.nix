# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.pkgs = (import ../config.nix {}).pkgs;

  nix = {
    binaryCaches = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };


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
    # eog
    apg
    appimage-run
    autossh
    baobab
    blueman
    bluez
    brogue
    broot
    cachix
    chromium
    coq
    coreutils
    ctags
    clang
    curl
    dbeaver
    dhall
    dhall-json
    # dhall-text
    direnv
    dmenu
    docker-compose
    dropbox
    dunst
    easyrsa
    emacsGcc
    etcher
    evince
    exfat
    fd
    feh
    ffmpeg
    firefox
    font-manager
    fzf
    gimp
    git
    gitg
    gmrun
    gnucash
    gnupg
    gparted
    graphviz
    htop
    httpie
    imagemagick
    inkscape
    jq
    killall
    kitty
    lsof
    neovim
    nethack
    nmap
    ormolu
    p7zip
    pandoc
    pavucontrol
    postman
    pwgen
    ripgrep
    rsync
    silver-searcher
    sqlite
    stalonetray
    tmux
    vlc
    wget
    xmobar
    xsel
    xsv
    youtube-dl
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

       # binaryCaches = [
       #     # http://18.185.36.89:8080 # aws build0
       #    # "http://80.158.35.108:5000" # otc build0
       #     # http://192.168.1.208:5000 # otc build0
       #     https://cache.nixos.org/
       #    "https://hie-nix.cachix.org"
       # ];
       # binaryCachePublicKeys = [
       #     "askby-1:fXvc/TFyDlDENEb5U35P+UgLhfpHn6mCYemxtzxtS+k="
       #     "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
       #     "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
       # ];

       # nixPath = [
       #     "nixpkgs-overlays=/home/stefan/repos/apkgs/overlays"
       #     "apkgs=/home/stefan/repos/apkgs"
       #     "ssh-config-file=/nix/store/4vxmfvdj9fl5adw48y5sq5hnxqg25by2-config"
       #     # "nixpkgs=/home/stefan/repos/askby_nixpkgs"
       #     # "nixos-config=/etc/nixos/configuration.nix"
       # ];

       # nixPath =
       #   [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs"
       #     "nixos-config=/etc/nixos/configuration.nix"
       #     "/nix/var/nix/profiles/per-user/root/channels"
       #   ]
       #   ++
       #   [
       #       # "nixpkgs-overlays=/home/stefan/repos/apkgs/overlays"
       #       "apkgs=/home/stefan/repos/apkgs"
       #       "ssh-config-file=/nix/store/4vxmfvdj9fl5adw48y5sq5hnxqg25by2-config"
       #   ];

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
    extraGroups = ["wheel" "networkmanager" "input" "docker" "video" "adbusers"];
    shell = pkgs.zsh;
    uid = 1000;
  };

  programs.slock.enable = true;

  networking.firewall.allowedTCPPorts = [5672 15672 8000 80 8303 8080 8888 5000 8612];
  networking.firewall.allowedUDPPorts = [5672 15672 8000 80 8303 8080 8888 5000 8612];
  networking.extraHosts = ''
    127.0.0.1 nginx-lua
    '';




  # services.rabbitmq = {
  #     enable = true;
  #     listenAddress = "0.0.0.0";
  #     port = 5672;
  #     plugins = ["rabbitmq_management"];
  #     cookie = "ri4zYzjkyU98WMLQ";
  # };

  # NOTE: run this once after creation
  # systemd.services.rabbitmq-setup = {
  #     serviceConfig.Type = "oneshot";
  #     enable = true;
  #     script = ''
  #         cat /var/lib/rabbitmq/.erlang.cookie > /root/.erlang.cookie
  #         chmod 0600 /root/.erlang.cookie
  #         export HOME=/root
  #         export PATH=/run/current-system/sw/bin/:$PATH
  #         rabbitmqctl add_user stefan foobar
  #         rabbitmqctl set_user_tags stefan administrator
  #         rabbitmqctl set_permissions -p / stefan ".*" ".*" ".*"
  #     '';
  # };

  # systemd.services.hoogle = {
  #   enable = true;
  #   script = ''
  #     /home/stefan/.nix-profile/bin/hoogle server -p 7777 --local
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };

  # services.prometheus = {
  #   enable = true;
  #   scrapeConfigs = [
  #     {
  #     job_name = "prometheus";
  #     static_configs = [{targets = ["localhost:9090"];}];
  #   }
  #     {
  #     job_name = "bibot";
  #     scrape_interval = "1s";
  #     static_configs = [{targets = ["localhost:8280"];}];
  #   }
  #     {
  #     job_name = "wtproxy";
  #     scrape_interval = "1s";
  #     static_configs = [{targets = ["localhost:8281"];}];
  #   }
  #   ];
  # };

  # services.grafana = {
  #   enable = true;
  #   port = 3301;
  #   # NOTE: this doesn't work afterwards
  #   # security =  {
  #   #   adminUser = "askby";
  #   #   adminPassword = "smtvftlw";
  #   # };
  # };

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

  # services.openvpn.servers = {
  #     aws = {
  #         autoStart = true;

  #         config = ''
  #         remote 18.195.23.67 1194
  #         client
  #         dev tun
  #         proto udp
  #         resolv-retry infinite
  #         nobind
  #         persist-key
  #         persist-tun
  #         remote-cert-tls server
  #         remote-cert-ku a0

  #         ;cipher AES-128-CBC
  #         ;auth SHA256
  #         comp-lzo
  #         verb 1

  #         pkcs12 /home/stefan/.openvpn/stefan.p12

  #         <tls-auth>
  #         -----BEGIN OpenVPN Static key V1-----
  #         5be0a3241fce9547bff5223cdec19868
  #         17d58ed2a39885b236596355331f596a
  #         8342ea20ba69fc8d2ac5de06314f04a5
  #         ce35d88252e3e447c4115a7b3f219208
  #         08da0ac941e3f0fcb2062ab60dd5f102
  #         322943c95864e3e149aaf33cb91ce1ee
  #         ee2835dd47a4ce0a12e175255da63dc4
  #         712fed6e99d256e52ecbc5b742a328fc
  #         3c0f79ded5a047df02b32e4e7ceb2c3d
  #         6ccdbc3ca0ffa474f60ef84f7aae276d
  #         5985b998e501d75afdb246b01f2dd99c
  #         7c20d96d9238ed0dacbdfd367421a045
  #         d6a2a1dde2cf1d910baa7f4f94b637ba
  #         7540914ec2c443fbbeba747ecba6a667
  #         5642e07fcd4477b2ac37f2e4e384e4a0
  #         7209002c4d0fc686437bbd5e7b3fa63e
  #         -----END OpenVPN Static key V1-----
  #         </tls-auth>
  #         '';
  #     };
  # };

  services.postgresql.enable = true;

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mysql;
  # };

  fonts.fonts = with pkgs; [
      # noto-fonts
      # noto-fonts-cjk
      # noto-fonts-emoji
      # liberation_ttf
      fira-code
      fira-code-symbols
      # mplus-outline-fonts
      # dina-font
      # proggyfonts
  ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "suspend";

  # services.squid = {
  #   enable = true;
  #   configText = ''
  #     # Recommended minimum configuration (3.5):
  #     #

  #     # Example rule allowing access from your local networks.
  #     # Adapt to list your (internal) IP networks from where browsing
  #     # should be allowed
  #     acl localnet src 10.0.0.0/8     # RFC 1918 possible internal network
  #     acl localnet src 172.16.0.0/12  # RFC 1918 possible internal network
  #     acl localnet src 192.168.0.0/16 # RFC 1918 possible internal network
  #     acl localnet src 169.254.0.0/16 # RFC 3927 link-local (directly plugged) machines
  #     acl localnet src fc00::/7       # RFC 4193 local private network range
  #     acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines

  #     acl SSL_ports port 443          # https
  #     acl Safe_ports port 80          # http
  #     acl Safe_ports port 21          # ftp
  #     acl Safe_ports port 443         # https
  #     acl Safe_ports port 70          # gopher
  #     acl Safe_ports port 210         # wais
  #     acl Safe_ports port 1025-65535  # unregistered ports
  #     acl Safe_ports port 280         # http-mgmt
  #     acl Safe_ports port 488         # gss-http
  #     acl Safe_ports port 591         # filemaker
  #     acl Safe_ports port 777         # multiling http
  #     acl CONNECT method CONNECT

  #     #
  #     # Recommended minimum Access Permission configuration:
  #     #
  #     # Deny requests to certain unsafe ports
  #     http_access deny !Safe_ports

  #     # Deny CONNECT to other than secure SSL ports
  #     http_access deny CONNECT !SSL_ports

  #     # Only allow cachemgr access from localhost
  #     http_access allow localhost manager
  #     http_access deny manager

  #     # We strongly recommend the following be uncommented to protect innocent
  #     # web applications running on the proxy server who think the only
  #     # one who can access services on "localhost" is a local user
  #     http_access deny to_localhost

  #     # Application logs to syslog, access and store logs have specific files
  #     cache_log       syslog
  #     access_log      stdio:/var/log/squid/access.log
  #     cache_store_log stdio:/var/log/squid/store.log

  #     # Required by systemd service
  #     pid_filename    /run/squid.pid

  #     # Run as user and group squid
  #     cache_effective_user squid squid

  #     #
  #     # INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
  #     #
  #     maximum_object_size 1024 MB
  #     max_stale 2 weeks
  #     cache_dir ufs /var/cache/squid3 10240 32 512

  #     # refresh pattern for debs and udebs
  #     refresh_pattern deb$   129600 100% 129600
  #     refresh_pattern udeb$   129600 100% 129600
  #     refresh_pattern tar.gz$  129600 100% 129600
  #     refresh_pattern tar.xz$  129600 100% 129600
  #     refresh_pattern tar.bz2$  129600 100% 129600

  #     # Example rule allowing access from your local networks.
  #     # Adapt localnet in the ACL section to list your (internal) IP networks
  #     # from where browsing should be allowed
  #     http_access allow localnet
  #     http_access allow localhost

  #     # allow everyone
  #     http_access allow all

  #     # Squid normally listens to port 3128
  #     http_port 3128

  #     # Leave coredumps in the first cache dir
  #     coredump_dir /var/cache/squid

  #     #
  #     # Add any of your own refresh_pattern entries above these.
  #     #
  #     refresh_pattern ^ftp:           1440    20%     10080
  #     refresh_pattern ^gopher:        1440    0%      1440
  #     refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
  #     refresh_pattern .               0       20%     4320
  #   '';
  #   # extraConfig = ''
  #   #     maximum_object_size 1024 MB
  #   #     max_stale 2 weeks
  #   #     cache_dir ufs /var/cache/squid3 10240 32 512
  #   #     refresh_pattern . 60 50% 14400 store-stale
  #   # '';
  # };

  programs.zsh.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
  programs.adb.enable = true;

}
