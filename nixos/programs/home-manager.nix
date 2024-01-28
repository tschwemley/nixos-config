{inputs, ...}: {
  imports = [inputs.home-manager.nixosModule];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
  };
}
