{
  self,
  withSystem,
  pkgs,
  ...
}: let
  mkSystem = systemString: configPath:
    withSystem systemString ({
      system,
      pkgs,
      ...
    }:
      self.inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit (self) inputs homeConfigurations;
          inherit pkgs;
        };

        modules = [
          configPath
        ];
      });
in {
  flake = {
    nixosConfigurations = {
      charizard = mkSystem "x86_64-linux" ./charizard;
      ditto = mkSystem "x86_64-linux" ./ditto;
      moltres = mkSystem "x86_64-linux" ./moltres;
      zapados = mkSystem "x86_64-linux" ./zapados;
    };
  };
}
