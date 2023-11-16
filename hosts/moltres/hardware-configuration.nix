{modulesPath, ... }: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
		(modulesPath + "/profiles/qemu-guest.nix")
		disko.nixosModules.disko
	];
	
	disko.devices = import ./disk-config.nix {
		lib = nixpkgs.lib;
	};
	
	boot.loader.grub = {
		devices = [ "/dev/sda" ];
		efiSupport = true;
		efiInstallAsRemovable = true;
	};
}
