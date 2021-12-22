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
]
