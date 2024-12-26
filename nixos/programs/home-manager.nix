{
  config,
  inputs,
  inputs',
  ...
}: {
  imports = [inputs.home-manager.nixosModule];
  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs inputs';
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      {inherit (config) lib;} # expose system lib to home-manager modules
    ];
    useGlobalPkgs = true;
  };
}
