{
  inputs,
  pkgs,
  ...
}: let
  mkHome = system: extraModules:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {inherit inputs pkgs;};
      modules = [inputs.sops-nix.homeManagerModule] ++ extraModules;
    };
  # );
in {
  droid = mkHome "aarch64-linux" [
    ./profiles/droid.nix
  ];

  work = mkHome "aarch64-darwin" [
    ./profiles/work.nix
  ];
}
