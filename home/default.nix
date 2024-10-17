{
  inputs,
  withSystem,
  ...
}:
let
  mkHome =
    system: extraModules:
    withSystem system (
      { pkgs, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            _module.args = {
              inherit inputs system;
            };
          }
          inputs.sops-nix.homeManagerModule
        ] ++ extraModules;
      }
    );
in
{
  flake.homeConfigurations = {
    work = mkHome "aarch64-darwin" [
      ./profiles/work.nix
    ];
  };
}
