{
  imports = [
    (import ../../modules/disks/btrfs-ephemeral.nix {
      diskName = "/dev/vda";
      swapSize = "2G";
    })
    (import ../../modules/disks/btrfs-block-storage.nix {diskName = "/dev/sda";})
  ];
}
