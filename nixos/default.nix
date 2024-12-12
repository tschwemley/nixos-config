{
  inputs,
  withSystem,
  ...
}: let
  mkSystem = systemString: configPath:
    withSystem systemString (
      {
        inputs',
        pkgs,
        system,
        ...
      }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = let
            secretsPath = ../secrets;
          in {
            inherit inputs inputs' pkgs secretsPath;
          };

          modules = [
            configPath
          ];
        }
    );
in {
  flake.nixosConfigurations = {
    articuno = mkSystem "x86_64-linux" ./hosts/articuno;
    charizard = mkSystem "x86_64-linux" ./hosts/charizard;
    eevee = mkSystem "x86_64-linux" ./hosts/eevee;
    flareon = mkSystem "x86_64-linux" ./hosts/flareon;
    jolteon = mkSystem "x86_64-linux" ./hosts/jolteon;
    machamp = mkSystem "x86_64-linux" ./hosts/machamp;
    moltres = mkSystem "x86_64-linux" ./hosts/moltres;
    pikachu = mkSystem "x86_64-linux" ./hosts/pikachu;
    tentacool = mkSystem "x86_64-linux" ./hosts/tentacool;
    zapados = mkSystem "x86_64-linux" ./hosts/zapados;
  };
}
