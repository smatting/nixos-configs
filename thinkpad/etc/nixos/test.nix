# let pkgs = import <nixpkgs> { overlays = [(import ./overlay.nix)]; };
let pkgs = import <nixpkgs> {};
in pkgs.callPackage ./openresty.nix {}
# in pkgs.nginxCustom

