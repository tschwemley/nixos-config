let
  # these names are consistent across the proxmox nodes
  rootName = /dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0;  
  storageName = /dev/disk-by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1;  

  root = import ./ephemeral-root.nix {diskName = rootName;};
  storage = import ./block-storage.nix {diskName = storageName;};
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
