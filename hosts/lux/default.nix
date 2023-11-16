{ ... }:

{
	imports = [ 
		./hardware-configuration.nix 
		../common.nix
	];

	boot.loader.grub.enable = true;
	boot.loader.grub.version = 2;
}
