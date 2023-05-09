{ self, ... }: {
	imports = [
		self.nixosModules.programs.neovim
		self.nixosModules.programs.wezterm
	];
}
