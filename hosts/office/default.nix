{ self, ... }: {
	imports = [
		./hardware-configuration.nix
		../pc.nix
	];
	
	networking = {
		hostname = "office";
		networkmanager.enable = true;
	};
	
	system.stateVersion = "23.05"; # Did you read the comment?
}
