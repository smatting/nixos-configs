{
  description = "My nixos config";

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
              cups-zj-58 = super.callPackage ./nixos/zj-58/default.nix { };
              lowbattery = super.python3Packages.callPackage
                (
                  builtins.fetchTarball
                    {
                      url = https://github.com/smatting/low-battery/archive/2de915f91fd18d4ad8f810ab676a67f19fa26354.tar.gz;
                      sha256 = "0mi5yljvig2frfdxclhhykz9a5xg9vw8sy8hdddka0pv165z58jj";
                    }
                )
                { };
              nixpkgsSource = "${nixpkgs}";
            }
        )
      ];
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-12.2.3"
          ];
        };
        inherit overlays;
      };
      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations = {
        bjorn = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

    };
}
