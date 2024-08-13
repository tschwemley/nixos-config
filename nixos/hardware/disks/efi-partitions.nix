{
      ESP = {
        size = "512M";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };
      root = {
        size = "100%";
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
}
