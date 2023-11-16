{
  diskName,
  swapSize,
  ...
}: {
  disko.devices = {
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
              name = "impermanence";
              start = "512M";
              end = "-" + swapSize;
              part-type = "primary";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "/home" = {
                    mountOptions = ["compress=lzo" "noatime"];
                  };
                  "/nix" = {
                    mountOptions = ["compress=lzo" "noatime"];
                  };
                  "/persist" = {
                    mountOptions = ["compress=lzo"];
                  };
                };
              };
            }
            {
              name = "swap";
              start = "-" + swapSize;
              end = "100%";
              part-type = "primary";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            }
          ];
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = ["size=1G"];
      };
    };
  };
}
