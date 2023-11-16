{ self, ... }: 

{
	imports = [
		../../modules/nixos/common.nix
		../../modules/nixos/boot/systemd.nix
		../../modules/nixos/k3s/server.nix
		# ./modules/common.nix	
		# ./modules/k3s/server.nix	
		
	];
}

