{
  self,
  inputs,
  ...
}:
{
  imports = [ self.inputs.home-manager.nixosModules.default ];

  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit self inputs; };
    sharedModules = [
      self.inputs.nix-private.homeManagerModules.yt-dlp
      self.inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
