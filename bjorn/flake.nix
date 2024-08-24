{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # pkgs = import nixpkgs {
      #   inherit system;
      #   config = {
      #     allowUnfree = true;
      #     permittedInsecurePackages = [
      #       "electron-12.2.3"
      #     ];
      #   };
      #   inherit overlays;
      # };
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; };
    in
    {

      packages."${system}".a = pkgs.appimage-run;

      nixosConfigurations = {
        bjorn = lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

    };
}
