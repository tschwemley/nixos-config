{ nixosModules, ... }: 

{
	imports = [
		# ./common.nix
		# nixosModules.display.x11
		nixosModules.gaming
		# modules.hardware.disks.encryptedRoot
		# modules.hardware.disks.ephemeralBtrfs
		# modules.pc
	];
}
