{inputs, ...}: {
  imports = [inputs.home-manager.nixosModule];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    sharedModules = [inputs.sops.homeManagerModule];
    useGlobalPkgs = true;
  };
}
