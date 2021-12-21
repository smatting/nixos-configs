[
  (
    self: super:
        (import (
            builtins.fetchTarball {
                url = "https://github.com/nix-community/emacs-overlay/archive/08d56ffc152b4500fe061b23340c8b185b3cf140.tar.gz";
                sha256 = "08avsicfdn1ww1apfz10n37fzniz68ldlaxx5y6a1zp78lbpvmah";
            }
        )) self super
  )
  (
    self: super:
    {
      cups-zj-58  = super.callPackage ./nixos/zj-58/default.nix {};
    }
  )
]
