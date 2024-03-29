let
  root = diskName: import ./ephemeral-root.nix {inherit diskName;};
  rootWithGrub = diskName:
    import ./ephemeral-root.nix {
      inherit diskName;
      useGrub = true;
    };
  storage = diskName: import ./block-storage.nix {inherit diskName;};
in rec {
  buyvm = {
    imports = [
      (rootWithGrub "/dev/vda")
      (import ./swap.nix)
    ];
  };
  buyvmWithStorage = {
    imports = [
      buyvm
      (storage "/dev/sda1")
    ];
  };
  charizard = {
    imports = [
      (import ./btrfs-encrypted.nix {diskName = "nvme1n1";})
    ];
  };
  proxmox = {
    imports = [
      (root "/dev/sda")
      (storage "/dev/sdb")
      (import ./swap.nix)
    ];
  };
}
