{diskName}: let
  partitions = [
    {
      name = "storage";
      start = "0";
      end = "100%";
      part-type = "primary";
      content = {
        type = "btrfs";
        extraArgs = ["-f"];
        subvolumes = {
          "/storage" = {
            mountpoint = "/storage";
            mountOptions = ["compress=lzo"];
          };
        };
      };
    }
  ];
in {
  disko.devices.disk.storage = {
    type = "disk";
    device = diskName;
    content = {
      inherit partitions;
      type = "table";
      format = "gpt";
    };
  };
}
