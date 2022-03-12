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
      paths = with pkgs; [

coreutils
curl
man
emacs
fd
htop
ffmpeg
gnupg
jq
lsof
nethack
p7zip
pwgen
ripgrep
sqlite
openssh
bash
tmux
weechat
youtube-dl
wget
rsync
git
direnv
shellcheck
taskwarrior
tmate
timewarrior
(python3.withPackages(ps: with ps; [
      ipdb
      ipython
      plumbum
      requests
      pyyaml
    ]))

      ];
  };
}
