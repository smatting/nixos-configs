{ sources ? import ./nix/sources.nix }:
rec {
  pkgs = import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
    # overlays = import ./overlays.nix;
  };
  nixpkgs = import sources.nixpkgs;
  env = pkgs.buildEnv {
    name = "macbook-env";
    paths = with pkgs;
    let python3wp  =
      (python3.withPackages(ps: with ps; [
        ipdb
        ipython
        plumbum
        requests
        pyyaml
      ]));
      update-macbook = callPackage ./update-macbook {};
    in

    [
      bash
      coreutils
      curl
      direnv
      emacs
      fd
      ffmpeg
      git
      gnupg
      htop
      jq
      lsof
      man
      nethack
      openssh
      p7zip
      pwgen
      python3wp
      ripgrep
      rsync
      shellcheck
      sqlite
      taskwarrior
      timewarrior
      tmate
      tmux
      update-macbook
      weechat
      wget
      youtube-dl
    ];
  };
}
