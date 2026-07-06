{
  self,
  inputs,
  lib,
  ...
}:
{
  imports = [ self.inputs.home-manager.nixosModules.default ];

  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;

    extraSpecialArgs = {
      inherit self inputs;
      lib = lib.extend (_: _: self.inputs.home-manager.lib);
    };
    sharedModules = [
      self.inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
