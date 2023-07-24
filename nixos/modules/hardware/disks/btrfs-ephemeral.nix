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
                    "/rootfs" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd"];
                    };
                    "/home" = {
                      mountOptions = ["compress=zstd"];
                    };
                    "/nix" = {
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/persist" = {
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/swap" = {
                      mountOptions = ["noatime" "nodatacow"];
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

  fileSystems."/".neededForBoot = true;
  fileSystems."/home".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
}
