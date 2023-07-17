{
  inputs,
  withSystem,
  ...
}: {
  flake.homeConfigurations = {
    # schwem = mkHomeConfig "schwem" [ ./profiles/pc.nix ];
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
  };
}
