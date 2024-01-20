{
  mainDiskName,
  storageDiskName,
  useGrub ? false,
  ...
}: let
  # TODO: make this generic
  mainPartitions =
    if useGrub
    then [
      {
        name = "boot";
        start = "0";
        end = "1M";
        flags = ["bios_grub"];
      }
    ]
    else
      []
      ++ [
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
          end = "100%";
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
        }
      ];

  storagePartitions = [
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
  disko = {
    devices = {
      disk = {
        main = {
          type = "disk";
          device = mainDiskName;
          content = {
            type = "table";
            format = "gpt";
            partitions = mainPartitions;
          };
        };
        storage = {
          type = "disk";
          device = storageDiskName;
          content = {
            type = "table";
            format = "gpt";
            partitions = storagePartitions;
          };
        };
      };
    };
  };

  boot.supportedFilesystems = ["btrfs"];
  fileSystems."/".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  # fileSystems."/storage".neededForBoot = true;
}
