storageDisk: let
  # root is always /dev/vda on the vm
  root = import ./ephemeral-root.nix "/dev/vda";
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
