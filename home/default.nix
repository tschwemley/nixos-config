{
  inputs,
  withSystem,
  ...
}: let
  mkHome = system: extraModules:
    withSystem system (
      {
        inputs',
        pkgs,
        ...
      }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            [
              {
                _module.args = let
                  secretsPath = ../secrets;
                in {
                  inherit inputs' secretsPath system;
                };
              }
              inputs.sops-nix.homeManagerModule
            ]
            ++ extraModules;
        }
    );
in {
  flake.homeConfigurations = {
    droid = mkHome "aarch64-linux" [
      ./profiles/droid.nix
    ];

    work = mkHome "aarch64-darwin" [
      ./profiles/work.nix
    ];
  };
}
