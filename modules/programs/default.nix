{ ... }: {
	bat = import ./bat;
	gui = import ./gui;
	neovim = import ./neovim;
	wezterm = import ./wezterm;

	common = {
		imports = [
			./bat 
			./neovim 
			./wezterm
		];
	};
}
