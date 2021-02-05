[
  (
    self: super:
        (import (
            builtins.fetchTarball {
                url = "https://github.com/nix-community/emacs-overlay/archive/290c3dd9a8ba3523d47cf07b31df8e3e50895f98.tar.gz";
                sha256 = "00hc17pkkc0ifvlvq6c0qvayqk1cjsgf7d29ma7xk3idz7rk9c9i";
            }
        )) self super
  )
]
