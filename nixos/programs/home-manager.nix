{
  self,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;

    extraSpecialArgs = {inherit self inputs;};
    sharedModules = [inputs.sops-nix.homeManagerModules.sops];
  };
}
