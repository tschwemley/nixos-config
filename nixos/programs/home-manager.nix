{
  inputs,
  inputs',
  ...
}: {
  imports = [inputs.home-manager.nixosModule];
  home-manager = let
    secretsPath = ../../secrets;
  in {
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs inputs' secretsPath;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
    useGlobalPkgs = true;
  };
}
