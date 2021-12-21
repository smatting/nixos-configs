{ sources ? import ./nix/sources.nix }:
rec {
  nixos = (import "${sources.nixpkgs}/nixos/default.nix") {
    configuration = import ./nixos/configuration.nix;
  };
  pkgs = import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
    overlays = import ./overlays.nix;
  };
}
