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
                extraOpenArgs = ["--allow-discards"];
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "rootfs" = {
                      mountpoint = "/";
                      mountOptions = ["defaults" "compress=zstd" "noatime"];
                    };
                    "home" = {
                      mountpoint = "/home";
                      mountOptions = ["defaults" "compress=zstd" "noatime"];
                    };
                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["defaults" "compress=zstd" "noatime"];
                    };
                    "persist" = {
                      mountpoint = "/persist";
                      mountOptions = ["defaults" "compress=zstd" "noatime"];
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

  fileSystems."/home".neededForBoot = true;
  #fileSystems."/persist".neededForBoot = true;
}
