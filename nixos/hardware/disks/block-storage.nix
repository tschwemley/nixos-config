diskName: mountpoint: let
  partitions = {
    storage = {
      size = "100%";
      content = {
        type = "btrfs";
        extraArgs = ["-f"];
        subvolumes = {
          "${mountpoint}" = {
            inherit mountpoint;
            mountOptions = ["compress=lzo"];
          };
        };
      };
    };
  };
in {
  disko.devices.disk.storage = {
    type = "disk";
    device = diskName;
    content = {
      inherit partitions;
      type = "gpt";
    };
  };
}
