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
      charizard = mkSystem "x86_64-linux" ./hosts/charizard.nix;
      moltres = mkSystem "x86_64-linux" ./hosts/moltres.nix;
    };
  };
}
