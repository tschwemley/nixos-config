{diskName, ...}: {
  disko = {
    devices = {
      disk = {
        storage = {
          device = diskName;
          type = "disk";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "/storage" = {
                mountOptions = ["compress=lzo"];
              };
            };
          };
        };
      };
    };
  };
}
