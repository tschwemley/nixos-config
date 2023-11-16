{
  inputs,
  withSystem,
  pkgs,
  ...
}: let
  mkSystem = configPath: systemString:
    withSystem systemString ({system, ...}:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        # specialArgs = {
        #   inherit inputs;
        # };
        modules = [
          {_module.args.inputs = inputs;}
          ./common.nix
          configPath
        ];
      });
in {
  flake = {
    nixosConfigurations = {
      charizard = mkSystem ./hosts/charizard "x86_64-linux";
      moltres = mkSystem ./hosts/moltres "x86_64-linux";
    };
  };
}
