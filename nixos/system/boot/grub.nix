diskName: let
  common = import ./common.nix;
in {
  grub = {
    boot = {
      inherit (common)kernelModules supportedFilesystems;
      loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = [diskName];
      };
    };
  };
}
