{ ... }: {
	barrier = import ./barrier.nix;
	bat = import ./bat.nix;
	git = import ./git.nix;
	homeManager = import ./home-manager.nix;
	neovim = import ./neovim;
	shell = import ./shell.nix;
	starship = import ./starship.nix;
	wezterm = import ./wezterm;
}
