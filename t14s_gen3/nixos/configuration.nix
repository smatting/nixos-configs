# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, overlays, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
  ];

  nixpkgs.overlays = overlays;

  # TODO: remove after hackathon
  services.cassandra = {
    enable = true;
    package = pkgs.cassandra_3_11;
  };

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
        plumbum
        requests
        pyyaml
        toposort
        python-lsp-server
        tabulate
      ]));
    in

    [
      _1password
      appimage-run
      arandr
      autossh
      awscli
      baobab
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
      dmenu
      dnsutils
      docker-compose
      dpkg
      dunst
      emacsNativeComp
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
      ncdu
      neovim
      nvim-ghost-python
      networkmanagerapplet
      newman
      niv
      nix-prefetch-github
      nixpkgs-fmt
      nix-output-monitor
      nodejs
      notify-desktop
      notify-osd
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
      xsv
      xsel
      # youtube-dl
      yq-go
      zoom-us
      apacheHttpd
      vbindiff
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
