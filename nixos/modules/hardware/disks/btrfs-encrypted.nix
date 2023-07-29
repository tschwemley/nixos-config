{diskName, ...}: {
  disko.devices = {
    disk = {
      "${diskName}" = {
        type = "disk";
        device = "/dev/${diskName}";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "EFI";
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                content = {
                  type = "btrfs";
                  extraArgs = ["--allow-discards"];
                  subvolumes = {
                    "rootfs" = {
                      mountpoint = "/";
                      mountOptions = ["defaults" "compress=zstd" "ssd" "noatime"];
                    };
                    "home" = {
                      mountpoint = "/home";
                      mountOptions = ["defaults" "autodefrag" "compress=zstd" "noatime" "ssd"];
                    };
                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["defaults" "compress=zstd" "noatime" "ssd"];
                    };
                    "persist" = {
                      mountpoint = "/persist";
                      mountOptions = ["defaults" "compress=zstd" "noatime" "ssd"];
                    };
                    "games" = {
                      mountpoint = "/games";
                      mountOptions = ["defaults" "autodefrag" "compress=zstd" "lazytime" "nofail" "noatime" "x-systemd.growfs" "space_cache=v2"];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  #fileSystems."/".neededForBoot = true;
  # fileSystems."/home".neededForBoot = true;
  #fileSystems."/persist".neededForBoot = true;
}
