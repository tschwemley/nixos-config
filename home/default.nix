{inputs, config, ...}: let
  mkHomeConfig = profile:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${builtins.currentSystem};
      modules = [
        ./profiles/common.nix
        profile
      ];
    };
in {
  flake.homeConfigurations = {
    pc = mkHomeConfig ./profiles/pc.nix;
    server = mkHomeConfig ./profiles/server.nix;
    work = mkHomeConfig ./profiles/work.nix;
  };
}
