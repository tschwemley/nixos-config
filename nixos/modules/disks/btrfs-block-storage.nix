{diskName, ...}: {
  disko.devices = {
    disk = {
      block = {
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
}
