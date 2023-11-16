{inputs, ...}: let
  mkHomeConfig = profile: {system ? "x86_64-linux"}:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      modules = [
        ./profiles/common.nix
        profile
      ];
    };
in {
  flake.homeConfigurations = {
    pc = mkHomeConfig ./profiles/pc.nix {};
    server = mkHomeConfig ./profiles/server.nix {};
    work = mkHomeConfig ./profiles/work.nix {};
  };
}
