{
  inputs,
  withSystem,
  ...
}: let
  mkHome = system: extraModules:
    withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          [
            {
              _module.args = {
                inherit inputs system;
              };
            }
          ]
          ++ extraModules;
      });
in {
  flake.homeConfigurations = {
    schwem = mkHome "x86_64-linux" [./profiles/pc.nix];
    "work@mac" = mkHome "aarch64-darwin" [./profiles/work.nix];
    # "work@dev" = mkHome "x86_64-linux" [ ./profiles/work.nix ];
  };
}
