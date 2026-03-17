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
              lowbattery = super.python3Packages.callPackage
                (
                  builtins.fetchTarball
                    {
                      url = https://github.com/smatting/low-battery/archive/1ddf367f1d6de4ba6f30e95e3833f466668572ba.tar.gz;
                      sha256 = "111igpb09q63bdv36h4yg3vs1szfdm02lqmclqb2hwhjffjdn45y";
                    }
                )
                { };
            }
        )
      ];
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        bjorn = lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
          ];
          specialArgs = { inherit overlays; };
        };
      };

    };
}
