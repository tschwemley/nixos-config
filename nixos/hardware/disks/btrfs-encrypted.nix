device: luksName: {
  imports = [./common.nix];

  disko.devices.disk.main = {
    inherit device;
    type = "disk";

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
            name = luksName;
            extraOpenArgs = ["--allow-discards"];

            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "rootfs" = {
                  mountpoint = "/";
                  mountOptions = ["defaults" "autodefrag" "compress=zstd" "noatime"];
                };

                "home" = {
                  mountpoint = "/home";
                  mountOptions = ["defaults" "autodefrag" "compress=zstd" "noatime"];
                };

                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["defaults" "autodefrag" "compress=zstd" "noatime"];
                };

                "persist" = {
                  mountpoint = "/persist";
                  mountOptions = ["defaults" "autodefrag" "compress=zstd" "noatime"];
                };

                # "games" = {
                #   mountpoint = "/games";
                #   mountOptions = ["defaults" "autodefrag" "autodefrag" "compress=zstd" "lazytime" "nofail" "noatime" "x-systemd.growfs" "space_cache=v2"];
                # };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/home".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
}
