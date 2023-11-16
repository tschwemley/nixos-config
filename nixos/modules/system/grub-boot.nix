{diskName, ...}: {
  loader = {
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [diskName];
    };
  };
}
