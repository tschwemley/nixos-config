let
  # these disk names are consistent across the proxmox nodes
  primaryDisk = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
  storageDisk = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";
  partitions = import ../hardware/disks/partitions.nix;

  root = import ../hardware/disks/ephemeral-root.nix primaryDisk partitions.efi;
  storage = import ../hardware/disks/block-storage.nix {device = storageDisk;};
in {
  imports = [
    ./server.nix

    ../system/boot/systemd.nix
    ../hardware/disks/swap.nix

    root
    storage
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
  ethDev = "ens18";
}
