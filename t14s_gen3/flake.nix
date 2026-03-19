{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-new.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-new }:
    let
      system = "x86_64-linux";

      claude-code = 
          let pkgs = import nixpkgs-new { inherit system; config.allowUnfree = true; };
        in
          pkgs.claude-code;

      overlays = [
        (
          self: super:
            {
              inherit claude-code;
              lowbattery = super.python3Packages.callPackage
                (
                  builtins.fetchTarball
                    {
                      url = https://github.com/smatting/low-battery/archive/1ddf367f1d6de4ba6f30e95e3833f466668572ba.tar.gz;
                      sha256 = "sha256:111igpb09q63bdv36h4yg3vs1szfdm02lqmclqb2hwhjffjdn45y";
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
