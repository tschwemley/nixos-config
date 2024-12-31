let
  # these disk names are consistent across the proxmox nodes
  partitions = import ./efi-partitions.nix;
  root = import ./ephemeral-root.nix "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0" partitions;
  storage = import ./block-storage.nix {diskName = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";};
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
