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
                url = "https://github.com/nix-community/emacs-overlay/archive/290c3dd9a8ba3523d47cf07b31df8e3e50895f98.tar.gz";
                sha256 = "00hc17pkkc0ifvlvq6c0qvayqk1cjsgf7d29ma7xk3idz7rk9c9i";
            }
        )) self super
  )
]
