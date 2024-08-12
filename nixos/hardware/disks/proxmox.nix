let
  # these names are consistent across the proxmox nodes
  rootName = "scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";  
  storageName = "scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";  

  root = import ./ephemeral-root.nix {diskName = rootName;};
  storage = import ./block-storage.nix {diskName = storageName;};
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
