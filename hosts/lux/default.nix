{ self, ... }:

{
	imports = [ 
		./hardware-configuration.nix 
		../common.nix
		self.nixosModules.services.k3s
	];

	boot.loader.grub.enable = true;
	boot.loader.grub.version = 2;
}
