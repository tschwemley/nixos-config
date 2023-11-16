{ self, ... }: 

{
	imports = [
		./hardware-configuration.nix
		../../modules/nixos/common.nix
		../../modules/nixos/boot/systemd.nix
		../../modules/nixos/k3s/server.nix
	];
}

