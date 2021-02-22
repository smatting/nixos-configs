# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.pkgs = (import ../config.nix {}).pkgs;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  nix.binaryCachePublicKeys = [ "wire-server.cachix.org-1:Xd170qZSd0X8ry+QzsQSVZuP3lIIQVfAJtthCk6/FLU=" ];
  nix.binaryCaches = [ "https://wire-server.cachix.org" ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0f0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    # eog
    # graphmod
    # xfd
    # xmessage

    awscli
    baobab
    blueman
    brightnessctl
    broot
    cabal-install
    cachix
    cassandra
    cookiecutter
    coreutils
    clang
    curl
    dbeaver
    dhall
    dhall-json
    direnv
    dmenu
    dnsutils
    docker-compose
    # dropbox
    dunst
    emacsGcc
    fd
    feh
    file
    firefox
    font-manager
    fzf
    gcc
    gdb
    ghcid
    gimp
    git
    gitg
    gmrun
    gnumake
    gnumeric
    google-chrome
    gparted
    graphviz
    haskellPackages.hoogle
    haskellPackages.hpack
    haskellPackages.implicit-hie
    kubernetes-helm
    hlint
    htop
    inconsolata
    jq
    jre
    jsonnet
    k9s
    killall
    kitty
    kubectl
    libinput-gestures
    libnotify
    libxml2
    moreutils
    neovim
    networkmanagerapplet
    newman
    niv
    nix-prefetch-github
    nodejs
    notify-desktop
    notify-osd
    openssl
    ormolu
    pandoc
    p7zip
    pavucontrol
    pinentry
    (python3.withPackages(ps: with ps; [plumbum ipython ipdb]))
    postman
    ripgrep
    scrot
    sct
    shellcheck
    signal-desktop
    silver-searcher
    spruce
    stalonetray
    telepresence
    tmate
    tmux
    tree
    unzip
    v4l-utils
    visidata
    v8
    vlc
    wget
    wire-desktop-internal
    xclip
    # xdot
    xfontsel
    xmagnify
    xmobar
    xsv
    yq-go
    zoom-us
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

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
  # sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      extraPackages = hpkgs: [
  	  # hpkgs.taffybar
  	  hpkgs.xmonad-contrib
  	  hpkgs.xmonad-extras
      ];
    };
  services.xserver.xkbOptions = "compose:caps";

  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "docker" ]; # Enable ‘sudo’ for the user.
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

  services.acpid.enable = true;
  programs.slock.enable = true;

  fonts.enableDefaultFonts = true;
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
  programs.gnupg.agent.pinentryFlavor = "curses";

  services.openssh.enable = true;

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";

  # environment.etc = {
  #   "resolv.conf".text = ''
  #     nameserver 8.8.8.8
  #     nameserver 1.1.1.1
  #     nameserver 9.9.9.9
  #   '';
  # };

}

