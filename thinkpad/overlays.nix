[
  (
    self: super:
        (import (
            builtins.fetchTarball {
                url = "https://github.com/nix-community/emacs-overlay/archive/72277c12eb58c9d56c4f12db803fd9e8d78f336a.tar.gz";
                sha256 = "1dbrxzy02m1haa53aaxqadn0xhkl94kd9svvjm0dhwvpp3rbbdgv";
            }
        )) self super
  )
]
