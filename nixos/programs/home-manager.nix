{
  self,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModule];
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;

    extraSpecialArgs = {inherit self inputs;};
    sharedModules = [inputs.sops-nix.homeManagerModules.sops];
  };
}
