{
  diskName,
  useGrub ? false,
  ...
}: let
  partitions =
    {
      ESP = {
        start = "1MiB";
        end = "128MiB";
        type = "EF00";
        priority = 1;
        # bootable = true;
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };
      root = {
        # start = "128MiB";
        # end = "100%";
        size = "100%";
        priority = 2;
        content = {
          type = "btrfs";
          extraArgs = ["-f"];
          subvolumes = {
            "/rootfs" = {
              mountpoint = "/";
              mountOptions = ["compress=lzo"];
            };
            "/home" = {
              mountpoint = "/home";
              mountOptions = [];
            };
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = ["compress=lzo" "noatime"];
            };
            "/persist" = {
              mountpoint = "/persist";
              mountOptions = ["compress=lzo" "noatime"];
            };
          };
        };
      };
    }
    // (
      if useGrub
      then {
        boot = {
          start = "0";
          end = "1M";
          type = "EF02";
        };
      }
      else {}
    );
in {
  imports = [./common.nix];
  disko.devices.disk.main = {
    type = "disk";
    device = diskName;
    content = {
      inherit partitions;
      type = "gpt";
    };
  };
}
