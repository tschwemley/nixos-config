let
  # these disk names are consistent across the proxmox nodes
  root = import ./ephemeral-root.nix "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
  storage = import ./block-storage.nix "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
