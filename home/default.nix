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
              home.stateVersion = "23.05";
            }
          ]
          ++ extraModules;
      });
in {
  flake.homeConfigurations = {
    wsl = mkHome "x86_64-linux" [
      ./profiles/wsl.nix
    ];
    "work@mac" = mkHome "aarch64-darwin" [./profiles/work.nix];
    "work@dev" = mkHome "x86_64-linux" [./profiles/work.nix];
  };
}
