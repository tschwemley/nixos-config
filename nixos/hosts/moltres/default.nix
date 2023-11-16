{ sops, ... }: 
{
	imports = [
		# disko.nixosModules.disko
		./hardware-configuration.nix
		../modules/nixos/common.nix
		../modules/nixos/boot/systemd.nix
		../modules/nixos/k3s/server.nix
	];
	
	{}: (import ../../modules/disko.nix)

	sops = {
		defaultSopsFile = ./secrets.yaml;
		sops.age.sshKeyPaths = ./moltres.pub
		sops.age.keyFile = "/var/lib/sops-nix/key.txt";
		# This will generate a new key if the key specified above does not exist
		sops.age.generateKey = true;
	};
}

