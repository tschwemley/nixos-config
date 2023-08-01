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
                start = "1MiB";
                end = "128MiB";
                bootable = true;
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              }
              {
                name = "root";
                start = "128MiB";
                end = "100%";
                part-type = "primary";
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
              }
            ];
          };
        };
      };
    };
  };

  boot.supportedFilesystems = ["btrfs"];
  fileSystems."/persist".neededForBoot = true;
}
