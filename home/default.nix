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
              _module.args.inputs = inputs;
            }
          ]
          ++ extraModules;
      });
in {
  flake.homeConfigurations = {
    # TODO: this would probably be cleaner if it was extra modules being passed into the profile
    schwem = mkHome "x86_64-linux" [./profiles/pc.nix];
    # inputs.hyprland.homeModules.default
    # "work@dev" = mkHome "x86_64-linux" [ ./profiles/work.nix ];
    # "work@mac" = mkHome "aarch64-darwin" [./profiles/work.nix];
  };
}
