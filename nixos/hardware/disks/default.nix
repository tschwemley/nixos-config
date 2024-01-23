let
  root = diskName: import ./ephemeral-root.nix {inherit diskName;};
  storage = diskName: import ./block-storage.nix {inherit diskName;};
in {
  buyvm = {
    imports = [
      (root "/dev/vda")
      (storage "/dev/sda")
    ];
  };
  proxmox = {
    imports = [
      (root "/dev/sda")
      (storage "/dev/sdb")
    ];
  };
}
