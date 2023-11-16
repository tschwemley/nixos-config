{ disks ? [ "/dev/vda", "/dev/sda" ], lib, pkgs, ... }: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "1MiB";
              end = "100MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";  
                mountOptions = [ "defaults" ];            
              };
            }
            {
              name = "main";
              start = "100MiB";
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
				subvolumes = [
					"/" = {
						mountOptions = [ "compress=ztsd" ]
					};
				];
			};
	  };
    };
  }; 
}
