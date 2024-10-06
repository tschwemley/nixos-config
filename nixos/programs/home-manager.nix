{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModule ];
  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
    useGlobalPkgs = true;
  };
}
