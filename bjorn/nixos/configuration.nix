# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, overlays, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];



  nix = {
    settings = {
      extra-platforms = config.boot.binfmt.emulatedSystems;
      trusted-users = [ "root" "stefan" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # nixPath = [ "nixpkgs=${pkgs.nixpkgsSource}" ];
  };
  nixpkgs.overlays = overlays;
  nixpkgs.config.allowUnfree = true;

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
  # networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # networking.nameservers = ["213.239.242.238"];
  networking.networkmanager.appendNameservers = [ "8.8.8.8" ];
  networking.hostName = "bjorn";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [ requests plumbum ipython ipdb pandas ]))
    apg
    arandr
    autossh
    awscli
    baobab
    blender
    broot
    cachix
    chromium
    clang
    claude-code
    coq
    coreutils
    crate2nix
    cryptsetup
    ctags
    curl
    dbeaver-bin
    dhall
    dhall-json
    dia
    direnv
    dive
    dmenu
    dnsutils
    docker-compose
    dropbox
    dunst
    easyrsa
    eog
    evince
    exfat
    fd
    feh
    ffmpeg
    file
    firefox
    font-manager
    fzf
    geckodriver
    gh
    ghostscript
    gimp
    git
    gitg
    gmrun
    gnucash
    gnumake
    gnupg
    google-chrome
    google-cloud-sdk
    gparted
    graphviz
    gthumb
    hcloud
    hledger
    htop
    httpie
    hyprpaper
    icecast
    imagemagick
    inkscape
    jmtpfs # for mounting android files
    jq
    killall
    kind
    kitty
    libnotify
    libreoffice
    lowbattery
    lsof
    mosquitto
    neovim
    nethack
    networkmanagerapplet
    niv
    nixpkgs-fmt
    nmap
    obsidian
    oneko
    openssl
    ormolu
    p7zip
    pandoc
    parted
    pavucontrol
    pwgen
    qjackctl
    rawtherapee
    rclone
    redshift
    ripgrep
    rsync
    rustup
    scrot
    shellcheck
    silver-searcher
    simple-scan
    sqlite
    stalonetray
    swaybg
    swayidle
    terraform
    tmux
    tree
    typst
    unzip
    vcs
    visidata
    vlc
    vscode
    weechat
    wget
    wl-clipboard
    wofi
    xan
    xclip
    xmobar
    xorg.xev
    xsel
    yq
    zsnes
  ];

  hardware.enableAllFirmware = true;
  # hardware.pulseaudio.enable = false;
  # hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  hardware.sane.enable = true;

  services.blueman.enable = true;
  #programs.light.enable = true;

  programs.waybar.enable = true;
  programs.hyprlock.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:



  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    logLevel = "debug";
    drivers = [ pkgs.gutenprint pkgs.pkgs.hplipWithPlugin  ];
    extraFilesConf = ''
      FileDevice Yes
    '';
  };

  services.upower.enable = true;
  # services.redis.enable = false;

  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = false;

  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    # extraPortals = [];

    extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    xkb.options = "compose:caps";
    xkb.layout = "us";

    videoDrivers = [ "modesetting" ];
    deviceSection = ''
      Option "TearFree" "True"
    '';



    # Enable the KDE Desktop Environment.
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true;
    # windowManager.xmonad = {
    #   enable = true;
    #   enableContribAndExtras = true;
    #
    #   extraPackages = hpkgs: [
    #     hpkgs.xmonad-contrib
    #     hpkgs.xmonad-extras
    #   ];
    # };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.stefan = {
    isNormalUser = true;
    home = "/home/stefan";
    description = "Stefan";
    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "jackaudio"
      "lp"
      "networkmanager"
      "scanner"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
    uid = 1000;
  };

  programs.slock.enable = true;

  networking.firewall.allowedTCPPorts = [ 5672 15672 8000 80 8303 8080 8888 5000 8612 ];
  networking.firewall.allowedUDPPorts = [ 6700 6701 6702 7000 7001 7002 7003 5672 15672 8000 80 8303 8080 8888 5000 8612 ];

  networking.extraHosts = ''
    127.0.0.1 nginx-lua
  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

  # services.postgresql.enable = true;

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mysql;
  # };

  fonts.packages = with pkgs; [
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
  services.teamviewer.enable = true;

  programs.zsh.enable = true;
  # services.udev.packages = [ pkgs.android-udev-rules ];
  # programs.adb.enable = true;
  programs.steam.enable = true;

  services.jack.jackd.enable = false;

  services.tailscale.enable = true;

  # services.jack = {
  #   jackd.enable = true;
  #   # support ALSA only programs via ALSA JACK PCM plugin
  #   alsa.enable = false;
  #   # support ALSA only programs via loopback device (supports programs like Steam)
  #   loopback = {
  #     enable = true;
  #     # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
  #     #dmixConfig = ''
  #     #  period_size 2048
  #     #'';
  #   };
  # };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  services.redis.enable = true;
  services.prometheus = {
    enable = true;

    pushgateway.enable = true;
    alertmanager.enable = true;
    alertmanager.configText = ''
    # global:
    #   # Global configuration
    #   smtp_smarthost: 'localhost:587'
    #   smtp_from: 'alertmanager@example.com'
    
    # Route configuration
    route:
      group_by: ['alertname']
      group_wait: 10s
      group_interval: 10s
      repeat_interval: 1h
      receiver: 'pushover-notifications'
    
    # Receivers configuration
    receivers:
    - name: 'pushover-notifications'
      pushover_configs:
      - token: 'aijvwms7yjk9o26rx6sahugrpeq5ty'
        send_resolved: false
        user_key: 'uvasnq79u2x5hzkd4n3ih55kghns5i'
        title: 'Alert: {{ .GroupLabels.alertname }}'
        message: |
          {{ range .Alerts }}
          Alert: {{ .Annotations.summary }}
          Description: {{ .Annotations.description }}
          Instance: {{ .Labels.instance }}
          Severity: {{ .Labels.severity }}
          Status: {{ .Status }}
          {{ end }}
        priority: '{{ if eq .Status "firing" }}1{{ else }}0{{ end }}'
        url: 'http://localhost:9090'  # Link to your Prometheus instance
        url_title: 'View in Prometheus'
    
    # Inhibit rules (optional - prevents duplicate alerts)
    # inhibit_rules:
    # - source_match:
    #     severity: 'critical'
    #   target_match:
    #     severity: 'warning'
    #   equal: ['alertname', 'dev', 'instance']
    '';

    scrapeConfigs = [
      {
        job_name = "pushgateway";
        static_configs = [{
          targets = [ "localhost:9091" ];
        }];
        scrape_interval = "15s";
      }
    ];

    extraFlags = [ "--web.enable-remote-write-receiver" ];
    retentionTime = "90d";
  };


}
