{ self, ... }: 
let
	modules = self.nixosModules;
in 
{
	imports = [
		./common.nix
		modules.display.x11
		modules.gaming
		modules.hardware.disks.encryptedRoot
		modules.hardware.disks.ephemeralBtrfs
		modules.pc
	];
}
