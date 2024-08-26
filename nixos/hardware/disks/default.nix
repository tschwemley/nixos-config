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
      (storage "/dev/sda")
    ];
  };
  charizard = {
    imports = [
      (import ./btrfs-encrypted.nix {diskName = "nvme1n1";})
    ];
  };
  pikachu = {
    imports = [
      (import ./btrfs-encrypted.nix {
        diskName = "nvme0n1";
        luksName = "pikachu-crypted";
      })
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
