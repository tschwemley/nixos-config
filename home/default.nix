{
  inputs,
  withSystem,
  ...
}: let
  mkHome = system: user: withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/pc.nix
          {
            home.username = user;
            home.homeDirectory = "/home/${user}";
          }
        ];
      });
in
{
  flake.homeConfigurations = {
    schwem = mkHome "x86_64-linux" "schwem";
    "work@linux" = mkHome "x86_64-linux" "tschwemley";
    /*
    schwem = withSystem "x86_64-linux" ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/pc.nix
          {
            home.username = "schwem";
            home.homeDirectory = "/home/schwem";
          }
        ];
      });
    */
  };
}
