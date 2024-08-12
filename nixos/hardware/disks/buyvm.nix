storageDisk: let
  # root is always /dev/vda on the vm
  root = import ./ephemeral-root.nix "";
  storage =
    if storageDisk != "/dev/vda"
    then import ./block-storage.nix storageDisk
    else {};
in {
  imports = [
    root
    storage
    ./swap.nix
  ];
}
