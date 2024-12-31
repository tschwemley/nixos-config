{
  diskName,
  mountpoint ? "storage",
  ...
}: let
  partitions = {
    "${mountpoint}" = {
      size = "100%";
      content = {
        type = "btrfs";
        extraArgs = ["-f"];
        subvolumes = {
          "/${mountpoint}" = {
            mountpoint = "/${mountpoint}";
            mountOptions = ["compress=lzo"];
          };
        };
      };
    };
  };
in {
  disko.devices.disk."${mountpoint}" = {
    type = "disk";
    device = diskName;
    content = {
      inherit partitions;
      type = "gpt";
    };
  };
}
