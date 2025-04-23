# Edit this configuration file to define what should be installed onconfigur
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, overlays, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
  ];

  hardware.bluetooth.enable = true;

  nixpkgs.overlays = overlays;

  # # TODO: remove after hackathon
  # services.cassandra = {
  #   enable = true;
  #   package = pkgs.cassandra_3_11;
  # };

  # devel
#   services.prometheus = {
#     enable = true;
#     extraFlags = [ "--web.enable-remote-write-receiver" ];
#     retentionTime = "20y";
#
#     configText = ''
# global:
#   query_log_file: /var/run/prometheus/querylog.txt
# alerting:
#   alertmanagers: []
# remote_read: []
# remote_write: []
# scrape_configs: []
# storage:
#   tsdb: 
#     out_of_order_time_window: 20y
# '';
  # };

  # services.nginx.enable = true;

  # services.grafana = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       # Listening Address
  #       http_addr = "127.0.0.1";
  #       # and Port
  #       http_port = 3000;
  #       # Grafana needs to know on which domain and URL it's running
  #       domain = "your.domain";
  #       root_url = "http://localhost:3000"; # Not needed if it is `https://your.domain/`
  #       serve_from_sub_path = true;
  #     };
  #   };
  # };

  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;

  nix =
    {
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      nixPath = [ "nixpkgs=${pkgs.nixpkgsSource}" ];

      settings = {
        trusted-users = [ "root" "stefan" ];
      };
    };


  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];


  # Use the systemd-boot EFI boot loader.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];


  security.pki.certificates = [
    # contents of /home/stefan/repos/wire-server-nixos/run/caddy/certificates/local/wildcard_.box1.local.wire.link/wildcard_.box1.local.wire.link.crt
    ''
-----BEGIN CERTIFICATE-----
MIIBpTCCAUqgAwIBAgIRALS5o5v73LoibXuMYvUfhUEwCgYIKoZIzj0EAwIwMDEu
MCwGA1UEAxMlQ2FkZHkgTG9jYWwgQXV0aG9yaXR5IC0gMjAyNCBFQ0MgUm9vdDAe
Fw0yNDA5MTExNTQ0MTVaFw0zNDA3MjExNTQ0MTVaMDAxLjAsBgNVBAMTJUNhZGR5
IExvY2FsIEF1dGhvcml0eSAtIDIwMjQgRUNDIFJvb3QwWTATBgcqhkjOPQIBBggq
hkjOPQMBBwNCAASNYH6XRfYcmYF8UflAu485UEdzU371p5+rc3zkAsZr0CCIE2Oy
hLC3EYeJeT4KmMt09xw6HksdxICEX0BdlwCco0UwQzAOBgNVHQ8BAf8EBAMCAQYw
EgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQU0bWsVdamlFyILBQrrmo2iTL9
6SMwCgYIKoZIzj0EAwIDSQAwRgIhAICLf3PC9Mo6hNCIKimntBc/ST2DXPvNBWxO
1VntVOuaAiEA1jMaeXlEHmQHWz1ttX6vkaXbj7X6+tIG4kI9UWobVHw=
-----END CERTIFICATE-----
    ''

   # /home/stefan/.mitmproxy/mitmproxy-ca-cert.pem

    ''
    -----BEGIN CERTIFICATE-----
    MIIDNTCCAh2gAwIBAgIURYolRAlxoGkUjZb3Wf63bXKGcekwDQYJKoZIhvcNAQEL
    BQAwKDESMBAGA1UEAwwJbWl0bXByb3h5MRIwEAYDVQQKDAltaXRtcHJveHkwHhcN
    MjIwNTA4MTE1MDQwWhcNMzIwNTA3MTE1MDQwWjAoMRIwEAYDVQQDDAltaXRtcHJv
    eHkxEjAQBgNVBAoMCW1pdG1wcm94eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
    AQoCggEBAMIpOM3yKMap9wRoMy/JCz2iBTtUX5tsJSjdpFabsFci4BySsqIEsMrj
    qnO3Imjj5bC6y5YTA4WycXTf3ITb3qcL6jFYGxSqH0ZlsfW0yoSM6vZ4WIeJfxAA
    +5XUr6nIZ8jWycAACeVqlBWfXvoRBoV02u4Muvc0MxzTt0zwNLKY0q/ENnhXtYl6
    A29rj3aIUKJrEWIrl+k/jUTBUlj8BdrizuWKG9qZaE9LP1MrdV7WHD5yH3HypfKv
    kYsySHl8eDouH67NDT3JUw+IJwgWK2QhO2vNBlXfW1Wl9BiDwZtM2Fgfk8UmVsnG
    UYx/Com9sPHIha44l85Hfr/VuibitHsCAwEAAaNXMFUwDwYDVR0TAQH/BAUwAwEB
    /zATBgNVHSUEDDAKBggrBgEFBQcDATAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYE
    FF6pQAKKTHwBdn6f8rfcEznHOeXqMA0GCSqGSIb3DQEBCwUAA4IBAQBq6jGS0YE6
    VNqMjRJcoIFX4lglyQq47WDkJf/Gfx3rdInxQ7y/4e18iD1UAv9PnnUO//TMenOf
    4/9jIcMiXS8zTZ9ru7CiBZbdQUTwN+wzUniNWU6FWGoDt5N9iOSNhro5VXZIL5tu
    psPUfFXaH+DagHl8Mwf5/EvNpj64i9DGS6IalPC6duSoGIUP8FyuNJFkPnzyVmaL
    PyLIVDp6drLLtceCO2QTWB1nlhIxq6e/+Dqa6TmjWTwF+2/xW/iyj9mFWuuxjTic
    paKMdwzshyeN774eC0Jpn2bC+8/7kg2uUaF0QXKNz+xI2lVh+Vtxjoic4R4k86as
    +U4YJk6+YUL4
    -----END CERTIFICATE-----
    ''
  ];

  networking.networkmanager.enable = true;
  # this fixes slow boots
  systemd.network.netdevs.wlp3s0.enable = false;
  systemd.network.wait-online.anyInterface = false;

  services.upower.enable = true;

  environment.extraInit = ''
  export PATH=~/.bin:$PATH
  '';
  environment.systemPackages = with pkgs;
    let
      pythonWithSomePackages = (python3.withPackages (ps: with ps; [
        ipdb
        ipython
        matplotlib
        pandas
        docopt
        plumbum
        requests
        pyyaml
        toposort
        python-lsp-server
        tabulate
        protobuf
        python-snappy
        prometheus-client
      ]));
    in

    [
      protobuf
      _1password-cli
      appimage-run
      arandr
      autossh
      awscli
      baobab
      bench
      binutils
      blueman
      brightnessctl
      broot
      buildah
      cabal-install
      cachix
      caddy
      cassandra_3_11
      clang
      cookiecutter
      coreutils
      curl
      dos2unix
      dbeaver-bin
      dhall
      dhall-json
      direnv
      dive
      dmenu
      dnsutils
      docker-compose
      dpkg
      dunst
      fd
      feh
      ffmpeg-full
      file
      firefox
      font-manager
      fzf
      gcc
      gdb
      gettext
      gimp
      git
      gitg
      github-cli
      gmrun
      eog
      gnumake
      gnumeric
      go
      gocryptfs
      google-chrome
      gparted
      graphviz
      haskellPackages.hoogle
      haskellPackages.hpack
      haskellPackages.implicit-hie
      hlint
      htop
      httpie
      hydrogen
      hyprpaper
      inconsolata
      ispell
      jira-cli-go
      jmtpfs
      joplin
      jq
      jre
      jsonnet
      k9s
      killall
      kitty
      kubectl
      kubernetes-helm
      libinput-gestures
      libnotify
      libxml2
      lowbattery
      moreutils
      mpv
      msmtp
      ncdu
      neovim
      nethack
      networkmanagerapplet
      newman
      niv
      nix-prefetch-github
      nixpkgs-fmt
      nix-output-monitor
      nodejs
      notify-desktop
      notify-osd
      oauth2c
      obs-studio
      openssl
      p7zip
      pandoc
      pavucontrol
      pinentry
      postgresql
      pulseaudio # for pactl
      # postman
      pwgen
      pythonWithSomePackages
      ripgrep
      runc
      rustup
      scrot
      sct
      shellcheck
      signal-desktop
      silver-searcher
      spruce
      slack
      stalonetray
      stern
      swayidle
      wayshot
      slurp
      taskwarrior3
      # telepresence
      terraform
      tig
      timewarrior
      tmate
      tmux
      tree
      unar
      unison-ucm
      unzip
      v4l-utils
      visidata
      vlc
      vnstat
      weechat
      wofi
      wl-clipboard
      wget
      xautolock
      xclip
      xfontsel
      xmagnify
      xmobar
      xorg.xev
      xorg.xmodmap
      xan
      xsel
      # youtube-dl
      yq-go
      zoom-us
      apacheHttpd
      vbindiff
      openfortivpn
      mitmproxy
      acpilight # for xbacklight -set 50
    ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = false;

  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      options = "compose:caps";
      layout = "us";
    };
    # Enable touchpad support.
    # windowManager.xmonad = {
    #   enable = true;
    #   enableContribAndExtras = true;
  
    #   extraPackages = hpkgs: [
    #     # hpkgs.taffybar
    #     hpkgs.xmonad-contrib
    #     hpkgs.xmonad-extras
    #   ];
    # };
  };
  


  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    # extraPortals = [];

    extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
          xdg-desktop-portal-hyprland
        ];
  };

  programs.waybar.enable = true;
  programs.hyprlock.enable = true;

  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "docker" "wireshark" ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  services.acpid.enable = true;
  programs.slock.enable = true;
  
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  fonts.enableDefaultPackages = true;
  time.timeZone = "Europe/Berlin";

  # services.kubernetes = {
  #   roles = ["master" "node"];
  #   masterAddress = "nixos";
  #   apiserver = {
  #     enable = true;
  #     advertiseAddress = "127.0.0.1";
  #     insecurePort = 8080;
  #   };
  # };
  programs.gnupg.agent.enable = true;

  services.openssh.enable = true;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";

  # environment.etc = {
  #   "resolv.conf".text = ''
  #     nameserver 8.8.8.8
  #     nameserver 1.1.1.1
  #     nameserver 9.9.9.9
  #   '';
  # };
  #
  services.vnstat.enable = true;

}
