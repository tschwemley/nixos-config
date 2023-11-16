{inputs, ...}: let
  mkHomeConfig = profile:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs;
      modules = [
        ./common.nix
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
