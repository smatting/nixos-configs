[
  (
    self: super:
        (import (
            builtins.fetchTarball {
                url = "https://github.com/nix-community/emacs-overlay/archive/8186f94aafaf8cb90f624b0ebc92d133fcfe7410.tar.gz";
                sha256 = "0sgs6j6bqsf9pqh7wazjjfmximaarvx0szcm6s4nsm10jsh5nd7i";
            }
        )) self super
  )
  (
    self: super:
    {
      cups-zj-58  = super.callPackage ./nixos/zj-58/default.nix {};
      lowbattery  = super.python3Packages.callPackage
        (
          builtins.fetchTarball
            {
              url = https://github.com/smatting/low-battery/archive/2de915f91fd18d4ad8f810ab676a67f19fa26354.tar.gz;
              sha256 = "0mi5yljvig2frfdxclhhykz9a5xg9vw8sy8hdddka0pv165z58jj";
            }
        ) {};
      supercollider-with-plugins = super.callPackage ./nix/supercollider/default.nix {};
    }
  )
]
