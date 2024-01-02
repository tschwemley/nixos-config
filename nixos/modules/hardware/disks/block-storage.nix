{diskName ? "/dev/sda", ...}: {
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
                name = "root";
                start = "0MiB";
                end = "100%";
                # part-type = "primary";
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "storage" = {
                      mountpoint = "/mnt/storage";
                      mountOptions = ["compress=lzo"];
                    };
                  };
                };
              }
            ];
          };
        };
      };

      boot.supportedFilesystems = ["btrfs"];
      fileSystems."/storage".neededForBoot = true;
    };
  };
}
