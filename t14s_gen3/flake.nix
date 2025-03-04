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
              nixpkgsSource = "${nixpkgs}";
              weechat = super.weechat.override {
                configure = { availablePlugins, ... }: {
                  scripts = with super.weechatScripts; [
                    wee-slack
                  ];
                };
              };

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
