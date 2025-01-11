storageDisk: {
  imports = [
    ./server.nix

    (import ../system/boot/grub.nix "/dev/vda")
    (import ../hardware/disks/buyvm.nix)
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
}
