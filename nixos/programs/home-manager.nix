{inputs, ...}: {
 imports = [inputs.home-manager.nixosModule];
  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
  };
}
