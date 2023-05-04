{ disks ? [ "/dev/vda" ], ... }: {
	disko.devices = {
		disk = {
			vdb = {
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
						name = "root";
						start = "512MiB";
						end = "100%";
						content = {
							type = "btrfs";
							extraArgs = [ "-f" ]; # Override existing partition
								subvolumes = {
									"/rootfs" = {
										mountpoint = "/";
									};
									"/home" = {
										mountOptions = [ "compress=zstd" "noatime" "ssd" ];
									};
									"/nix" = {
										mountOptions = [ "compress=zstd" "noatime" "ssd" ];
									};
								};
						};
					}
					{
						name = "swap";
						start = "-1G";
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
		};
		nodev."/" = {
			fsType = "tmpfs";
			mountOptions = [
				"size=2G"
					"defaults"
					"mode=755"
			];
		};
	};
								 }
