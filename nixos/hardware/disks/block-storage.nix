{
  device,
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
    inherit device;

    type = "disk";
    content = {
      inherit partitions;
      type = "gpt";
    };
  };
}
