{ diskName, swapSize, blockSize ? "1M", ... }: 
{
	disko.devices = {
		disk = {
		  main = {
			type = "disk";
			device = diskName;
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
							mountOptions = [ "noatime" ];
						};
					  };  
						postCreateHook = ''
							truncate -s 0 /swap/swapfile
							chattr +C /swap/swapfile
							btrfs property set /swap/swapfile compression none
							dd if=/dev/zero of=/swap/swapfile bs=1M count=${swapSize}
							chmod 0600 /swap/swapfile
							mkswap /swap/swapfile
						'';
					};
				}  
			  ];
				
			};
		  };
		};
	};
}
