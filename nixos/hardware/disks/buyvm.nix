storageDisk: let
  # root is always /dev/vda on the vm
  partitions = import ./grub-partition.nix // import ./efi-partitions.nix;
  root = import ./ephemeral-root.nix "/dev/vda" partitions;

  storage =
    if storageDisk != ""
    then import ./block-storage.nix storageDisk
    else {};
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
