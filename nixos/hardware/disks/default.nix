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
    ];
  };
  buyvmWithStorage = {
    imports = [
      buyvm
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
