{
  self,
  withSystem,
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
          inherit (self) inputs;
          inherit pkgs;
        };

        modules = [
          configPath
        ];
      });
in {
  flake.nixosConfigurations = {
    articuno = mkSystem "x86_64-linux" ./hosts/articuno;
    charizard = mkSystem "x86_64-linux" ./hosts/charizard;
    eevee = mkSystem "x86_64-linux" ./hosts/eevee;
    flareon = mkSystem "x86_64-linux" ./hosts/flareon;
    jolteon = mkSystem "x86_64-linux" ./hosts/jolteon;
    machamp = mkSystem "x86_64-linux" ./hosts/machamp;
    moltres = mkSystem "x86_64-linux" ./hosts/moltres;
    zapados = mkSystem "x86_64-linux" ./hosts/zapados;
  };
}
