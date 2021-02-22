[
  (
    self: super: {
      # NOTE: This is the internal development-build of wire. It is not meant for
      # public consumption and it comes with NO warranty whatsoever
      wire-desktop-internal = super.wire-desktop.overrideAttrs (old: old // rec {
        version = "3.20.43-internal-43";
        src = super.fetchurl {
          url = "https://wire-app.wire.com/linux-internal/debian/pool/main/WireInternal-3.20.43-internal_amd64.deb";
          sha256 = "1jq4hhcfix1p77fv5a9bd2mab5m5dairkbr61qwy8355n4b4sl83";
        };

        postFixup = ''
      makeWrapper $out/opt/WireInternal/wire-desktop-internal $out/bin/wire-desktop  "''${gappsWrapperArgs[@]}"
    '';
      });
    }
  )
  (
    self: super:
        (import (
            builtins.fetchTarball {
                url = "https://github.com/nix-community/emacs-overlay/archive/72277c12eb58c9d56c4f12db803fd9e8d78f336a.tar.gz";
                sha256 = "1dbrxzy02m1haa53aaxqadn0xhkl94kd9svvjm0dhwvpp3rbbdgv";
            }
        )) self super
  )
  (
    self: super: {
      spruce = self.callPackage ./nix/spruce {};
    }
  )
]
