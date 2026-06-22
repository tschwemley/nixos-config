{
  self,
  pkgs,
  ...
}:
let
  mkHome =
    system: extraModules:
    self.inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = { inherit self pkgs; };
      modules = [ self.inputs.sops-nix.homeManagerModule ] ++ extraModules;
    };
in
{
  droid = mkHome "aarch64-linux" [
    ./profiles/droid.nix
  ];

  work = mkHome "aarch64-darwin" [
    ./profiles/work.nix
  ];
}
