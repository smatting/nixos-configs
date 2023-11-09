{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      overlays = [
        (
          self: super:
            {
              lowbattery = super.python3Packages.callPackage
                (
                  builtins.fetchTarball
                    {
                      url = https://github.com/smatting/low-battery/archive/2de915f91fd18d4ad8f810ab676a67f19fa26354.tar.gz;
                      sha256 = "0mi5yljvig2frfdxclhhykz9a5xg9vw8sy8hdddka0pv165z58jj";
                    }
                )
                { };
            }
        )
        (
          self: super:
            (import (
              builtins.fetchTarball {
                url = "https://github.com/nix-community/emacs-overlay/archive/36d568cc76f0425a25a46770aae818e5a6cb7cf4.tar.gz";
                sha256 = "sha256:0vhb3asai6vgfwr429c1d2gr6n3d33kyd1s3f616d738s672cca7";
              }
            )) self
              super
        )
        (
          self: super:
          {
              nixpkgsSource = "${nixpkgs}";
          }
        )
      ];
      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
          ];
          specialArgs = { inherit overlays; };
        };
      };

    };
}
