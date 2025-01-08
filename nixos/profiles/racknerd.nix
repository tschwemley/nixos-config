{modulesPath, ...}: {
  imports = [
    ./server.nix

    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.grub.device = "/dev/vda1";
  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk"];

  # disks are generated by racknerd at launch -- just use them instead of btrfs
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/vda2";}
  ];
}
