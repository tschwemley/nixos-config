{ self, ... }:
{
	imports = [
		./hardware-configuration.nix # this is auto-generated and I don't see the need to change
		# self.nixosModules.desktop
		# self.nixosModules.development
		# self.nixosModules.shell
		# self.nixosModules.terminal
		# self.nixosModules.networking
	];

	system.stateVersion = "23.05";
}
