{ nixosModules, ... }: 
{
	imports = [
		./hardware-configuration.nix
		nixosModules.audio
		nixosModules.homeManager
		nixosModules.k3s
		nixosModules.services
		nixosModules.system
		# ../modules/nixos/common.nix
		# ../modules/nixos/boot/systemd.nix
		# ../modules/nixos/k3s/server.nix
	];

	networking.hostName = "moltres";
	# 
	# # {}: (import ../../modules/disko.nix)
	#
	# sops = {
	# 	defaultSopsFile = ./secrets.yaml;
	# 	age.sshKeyPaths = ./moltres.pub;
	# 	age.keyFile = "/var/lib/sops-nix/key.txt";
	# 	# This will generate a new key if the key specified above does not exist
	# 	age.generateKey = true;
	# };
}

