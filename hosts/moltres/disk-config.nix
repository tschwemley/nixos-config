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
              end = "100%";
			  content = {
                  type = "btrfs"; 
                  extraArgs = [ "-f" ];  
                  subvolumes = {                
                    "/" = {
                      mountOptions = [ "compress=ztsd" ];
                    };  
                    "/nix" = {
                      mountOptions = [ "compress=ztsd" "noatime" ];
					};  
                    "/persist" = {
                      mountOptions = [ "compress=ztsd" ];
					};  
                    "/swap" = {
                      mountOptions = [ "compress=ztsd" "noatime" ];
					};  
                  };  
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
						mountOptions = [ "compress=ztsd" ];
					};
				};
			};
	  };
    };
}
