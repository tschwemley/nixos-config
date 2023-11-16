{
  inputs,
  withSystem,
  ...
}: let
  mkHome = system: user: profile:
    withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          profile
          {
            home.username = user;
            home.homeDirectory = "/home/${user}";
          }
        ];
      });
in {
  flake.homeConfigurations = {
    schwem = mkHome "x86_64-linux" "schwem" ./profiles/pc.nix;
    "work@dev" = mkHome "x86_64-linux" "tschwemley" ./profiles/work.nix;
    "work@mac" = mkHome "x86_64-darwin" "tschwemley" ./profiles/work.nix;
  };
}
