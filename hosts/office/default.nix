{ self, ... }: {
		imports = [
			./hardware-configuration.nix
			../common.nix
			self.nixosModules.development
			self.nixosModules.gaming
			self.nixosModules.pc
		];
}
