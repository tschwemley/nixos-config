{diskName, ...}: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = diskName;
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
              device = diskName;
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = ["--allow-discards"];
                # if you want to use the key for interactive login be sure there is no trailing newline
                # for example use `echo -n "password" > /tmp/secret.key`
                #keyFile = "/tmp/secret.key"; # Interactive
                settings.keyFile = "/tmp/secret.key";
                # additionalKeyFiles = ["/tmp/additionalSecret.key"];
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["defaults" "compress=zstd" "ssd" "noatime"];
                    };
                    "/home" = {
                      mountOptions = ["defaults" "compress=zstd" "noatime" "ssd"];
                    };
                    "/nix" = {
                      mountOptions = ["defaults" "compress=zstd" "noatime" "ssd"];
                    };
                    "/persist" = {
                      mountOptions = ["defaults" "compress=zstd" "noatime" "ssd"];
                    };
                    "/games" = {
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
}
/*
{diskName, ...}: {
  disko = {
    devices = {
      disk = {
        main = {
          type = "disk";
          device = diskName;
          content = {
            type = "gpt";
            partitions = [
                ESP = {
              label = "EFI";
              name = "ESP";
              size = "512M";
              type = "EF00" ;
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
                extraOpenArgs = [ "--allow-discards" ];
                # if you want to use the key for interactive login be sure there is no trailing newline
                # for example use `echo -n "password" > /tmp/secret.key`
                #keyFile = "/tmp/secret.key"; # Interactive
                settings.keyFile = "/tmp/secret.key";
                additionalKeyFiles = ["/tmp/additionalSecret.key"];
                content = {
				  {
					name = "root";
					start = "512M";
					end = "100%";
					part-type = "primary";
					content = {
					  type = "btrfs";
					  extraArgs = ["-f"];
					  subvolumes = {
					  };
					};
				  };
			  }
            ];
          };
        };
      };
    };
  };

  #fileSystems."/".neededForBoot = true;
  #fileSystems."/home".neededForBoot = true;
  #fileSystems."/persist".neededForBoot = true;
}
*/

