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
      articuno = mkSystem "x86_64-linux" ./hosts/articuno;
      charizard = mkSystem "x86_64-linux" ./hosts/charizard;
      #ditto = mkSystem "x86_64-linux" ./hosts/ditto;
      eevee = mkSystem "x86_64-linux" ./hosts/eevee;
      moltres = mkSystem "x86_64-linux" ./hosts/moltres;
      zapados = mkSystem "x86_64-linux" ./hosts/zapados;
    };
  };
}
