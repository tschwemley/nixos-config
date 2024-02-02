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
    wsl = mkHome "x86_64-linux" [
      ./profiles/wsl.nix
    ];
  };
}
