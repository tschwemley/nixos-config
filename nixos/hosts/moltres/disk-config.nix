{
	imports = [
		(import ../../modules/disks/btrfs-ephemeral.nix { 
			diskName = "/dev/vda"; 
			swapSize = "2048";
		})
		(import ../../modules/disks/btrfs-block-storage.nix { diskName = "/dev/sda"; })
	];
}
