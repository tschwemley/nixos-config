storageDisk: {
  imports = [
    (import ../hardware/disks/buyvm.nix storageDisk)
    ./server.nix
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
}
