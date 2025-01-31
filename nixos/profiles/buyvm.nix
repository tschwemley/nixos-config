storageDisk: let
  primaryDisk = "/dev/vda";
  partitions = import ../hardware/disks/partitions.nix;
in {
  imports = [
    ./server.nix

    (import ../system/boot/grub.nix primaryDisk)
    (import ../hardware/disks/ephemeral-root.nix primaryDisk partitions.grubEfi)
    ../hardware/disks/swap.nix
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
}
