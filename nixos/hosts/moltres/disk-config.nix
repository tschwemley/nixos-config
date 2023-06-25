{diskName, ...}: {
  disko = {
    devices = {
      disk = {
        main = {
          type = "disk";
          device = diskName;
          content = {
            type = "table";
            format = "gpt";
            partitions = [
              {
                name = "boot";
                start = "0";
                end = "1M";
                flags = ["bios_grub"];
              }
              {
                name = "ESP";
                start = "1M";
                end = "512M";
                bootable = true;
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              }
              {
                name = "root";
                start = "512M";
                end = "100%";
                part-type = "primary";
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=lzo"];
                    };
                    "/home" = {
                      mountOptions = ["compress=lzo"];
                    };
                    "/nix" = {
                      mountOptions = ["compress=lzo" "noatime"];
                    };
                    "/persist" = {
                      mountOptions = ["compress=lzo" "noatime"];
                    };
                    # "/swap" = {
                    #   mountOptions = ["compress=lzo"];
                    # };
                  };
                };
              }
            ];
          };
        };
      };
    };
  };
}
