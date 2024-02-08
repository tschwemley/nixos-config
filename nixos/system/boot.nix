let
  kernelModules = ["wireguard"];
  supportedFilesystems = ["btrfs"];
in {
  grub = diskName: {
    boot = {
      inherit kernelModules supportedFilesystems;
      loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = [diskName];
      };
    };
  };

  systemd = {
    boot = {
      inherit kernelModules supportedFilesystems;
      initrd = {
        systemd.enable = true;
      };

      loader.systemd-boot = {
        enable = true;
        editor = false; # leaving true allows for root access to be gained via passing kernel param
      };
    };
  };
}
