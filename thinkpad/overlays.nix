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
    }
  )
  (
    self: super:
    {
      lowbattery  = super.python3Packages.callPackage
        (
          builtins.fetchTarball
            {
              url = https://github.com/smatting/low-battery/archive/2e4b2e4f0bb02d54fd7e6e7f601dafd1618018e3.tar.gz;
              sha256 = "0x0r7ziyq3xlq5zb02klbwcgv1j7iwq5il2sdlx41y7dv7xcg9xz";
            }
        ) {};
    }
  )
]
