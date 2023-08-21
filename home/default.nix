{
  inputs,
  withSystem,
  ...
}: let
  mkHome = system: modules:
    withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
      });
in {
  flake.homeConfigurations = {
    # TODO: this would probably be cleaner if it was extra modules being passed into the profile
    schwem = mkHome ("x86_64-linux" [
      ./profiles/pc.nix
      {home.username = "schwem";}
    ]);
    # "work@dev" = mkHome "x86_64-linux" [ ./profiles/work.nix ];
    # "work@mac" = mkHome "x86_64-darwin" [ ./profiles/work.nix ];
  };
}
