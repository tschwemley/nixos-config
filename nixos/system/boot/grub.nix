diskName: {
  imports = [./.];
    boot = {
      loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = [diskName];
      };
    };
}
