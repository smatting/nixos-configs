# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, overlays, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;

  nix =
    {
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      nixPath = [ "nixpkgs=${pkgs.nixpkgsSource}" ];
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

  # TODO: check if this fixes slow boots
  systemd.services.systemd-udev-settle.enable = false;

  systemd.services.NetworkManager-wait-online.enable = false;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  services.upower.enable = true;

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
      ]));
    in

    [
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
      # cassandra
      clang
      cookiecutter
      coreutils
      curl
      dbeaver
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
      gnome.eog
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
      inconsolata
      ispell
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
      neovim
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
      stalonetray
      stern
      taskwarrior
      telepresence
      tig
      timewarrior
      tmate
      tmux
      tree
      unar
      unison-ucm
      unzip
      v4l-utils
      v8
      visidata
      vlc
      vnstat
      weechat
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
      youtube-dl
      yq-go
      zoom-us
      vscode
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
  # sound.enable = true;
  hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "compose:caps";
    # Enable touchpad support.
    libinput.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      extraPackages = hpkgs: [
        # hpkgs.taffybar
        hpkgs.xmonad-contrib
        hpkgs.xmonad-extras
      ];
    };
  };

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

  services.acpid.enable = true;
  programs.slock.enable = true;

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
  programs.gnupg.agent.pinentryFlavor = "gtk2";

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
  
  programs.wireshark.enable = true;

}
