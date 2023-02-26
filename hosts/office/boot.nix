{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  # Kernel
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "uas" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable grub cryptodisk
  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-31e46ce1-608d-45f2-a643-3f9be34295da".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-31e46ce1-608d-45f2-a643-3f9be34295da".device = "/dev/disk/by-uuid/31e46ce1-608d-45f2-a643-3f9be34295da";
  
  # Enable swap on luks
  boot.initrd.luks.devices."luks-e27bbb1f-77b4-4cfe-af73-cb398ff255e5".device = "/dev/disk/by-uuid/e27bbb1f-77b4-4cfe-af73-cb398ff255e5";
  boot.initrd.luks.devices."luks-e27bbb1f-77b4-4cfe-af73-cb398ff255e5".keyFile = "/crypto_keyfile.bin";

}
