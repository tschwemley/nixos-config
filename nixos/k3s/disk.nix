{ disks ? [ "/dev/vdb" ], ... }:

{
    disko.devices = {
        disk = {
            vda = {
                type = "disk";
                device = builtins.elemAt disks 0;
                content = {
                    type = "table";
                    format = "gpt";
                    partitions = [
                    {
                        name = "ESP";
                        start = "1MiB";
                        end = "512MiB";
                        fs-type = "fat32";
                        bootable = true;
                        content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                        };
                    }
                    {
                        name = "nix";
                        start = "512M";
                        end = "100%";
                        part-type = "primary";
                        content = {
                            type = "btrfs";
                            extraArgs = "-f";
                            mountpoint = "/nix";
                            mountoptions = [ "compress=zstd discard" "noatime" ];
                        };
                    }
                };
            };

            sda = {
                type = "disk";
                device = builtins.elemAt disks 1;
                content = {
                    type = "table";
                    format = "gpt";
                    partitions = [
                    {
                        name = "root";
                        start = "1MiB";
                        end = "100%";
                        content = {
                            type = "btrfs";
                            extraArgs = [ "-f" ]; # Override existing partition
                                subvolumes = {
# Subvolume name is different from mountpoint
                                    "/rootfs" = {
                                        mountpoint = "/";
                                    };
# Mountpoints inferred from subvolume name
                                    "/home" = {
                                        mountOptions = [ "compress=zstd discard noatime" ];
                                    };
                                };
                        };
                    }
                    ];
                };
            };
        };
    };

   nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=4G"
        "defaults"
        "mode=755"
      ];
    };
  };
}
