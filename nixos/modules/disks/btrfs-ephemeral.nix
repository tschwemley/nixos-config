{
  diskName,
  swapSize,
  ...
}: {
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
                end = swapSize;
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
                      mountOptions = [];
                    };
                    "/nix" = {
                      mountOptions = ["compress=lzo" "noatime"];
                    };
                    "/persist" = {
                      mountOptions = ["compress=lzo" "noatime"];
                    };
                  };
                };
              }
              {
                name = "swap";
                start = swapSize;
                end = "100%";
                # part-type = "primary";
                content = {
                  type = "swap";
                  randomEncryption = true;
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
