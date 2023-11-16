{ disks ? [ "/dev/vda" "/dev/sda" ], ... }: {
    disk = {
      main = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
			{
				name = "boot";
				start = "0";
				end = "1M";
				flags = [ "bios_grub" ];
			}
            {
              name = "ESP";
              start = "1M";
              end = "512M";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";  
              };
            }
            {
              name = "main";
              start = "512M";
              end = "-2G";
			  part-type = "primary";
			  content = {
                  type = "btrfs"; 
                  extraArgs = [ "-f" ];  
                  subvolumes = {                
                    "/rootfs" = {
					  mountpoint = "/";
                      mountOptions = [ "compress=lzo" ];
                    };  
                    "/nix" = {
                      mountOptions = [ "compress=lzo" "noatime" ];
					};  
                    "/persist" = {
                      mountOptions = [ "compress=lzo" ];
					};  
                    "/swap" = {
                      mountOptions = [ "compress=lzo" "noatime" ];
					};  
                  };  
				};
            }  
			{
				name = "swap";
				start = "-2G";
				end = "100%";
				part-type = "primary";
				content = {
					type = "swap";
					randomEncryption = true;
				};
			}
          ];
        };
      };
	  
	  block = {
			device = builtins.elemAt disks 1;
			type = "disk";
			content = {
				type = "btrfs";
				extraArgs = [ "-f" ];
				subvolumes = {
					"/storage" = {
						mountOptions = [ "compress=lzo" ];
					};
				};
			};
	  };
    };
}
