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
                url = "https://github.com/nix-community/emacs-overlay/archive/36d568cc76f0425a25a46770aae818e5a6cb7cf4.tar.gz";
                sha256 = "sha256:0vhb3asai6vgfwr429c1d2gr6n3d33kyd1s3f616d738s672cca7";
            }
        )) self super
  )
  (
    self: super: {
      spruce = self.callPackage ./nix/spruce {};
    }
  )
  (
    self: super:
    {
      lowbattery  = super.python3Packages.callPackage
        (
          builtins.fetchTarball
            {
              url = https://github.com/smatting/low-battery/archive/2de915f91fd18d4ad8f810ab676a67f19fa26354.tar.gz;
              sha256 = "0mi5yljvig2frfdxclhhykz9a5xg9vw8sy8hdddka0pv165z58jj";
            }
        ) {};
    }
  )
]
