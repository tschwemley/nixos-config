let
  # these disk names are consistent across the proxmox nodes
  rootName = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
  storageName = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";

  partitions = import ./efi-partitions.nix;

  root = import ./ephemeral-root.nix rootName partitions;
  storage = import ./block-storage.nix storageName;
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
