diskName: let
  partitions =
    {
      ESP = {
        priority = 1;
        size = "128M";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };
      root = {
        # start = "128MiB";
        # end = "100%";
        size = "100%";
        priority = 2;
        content = {
          type = "btrfs";
          extraArgs = ["-f"];
          subvolumes = {
            "/rootfs" = {
              mountpoint = "/";
              mountOptions = ["compress=lzo"];
            };
            "/home" = {
              mountpoint = "/home";
              mountOptions = [];
            };
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = ["compress=lzo" "noatime"];
            };
            "/persist" = {
              mountpoint = "/persist";
              mountOptions = ["compress=lzo" "noatime"];
            };
          };
        };
      };
    };
in {
  imports = [./common.nix];
  disko.devices.disk.main = {
    type = "disk";
    device = diskName;
    content = {
      inherit partitions;
      type = "gpt";
    };
  };
}
