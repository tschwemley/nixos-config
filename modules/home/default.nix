{ config, pkgs, ... }: {
	flake.homeModules = {
		# audio = import ./audio;
		# desktop = import ./desktop;
		# development = import ./development;
		# gaming = import ./gaming;
		neovim = import ./neovim { inherit pkgs; };
		shell = import ./shell { inherit config; };
		# terminal = import ./terminal;
	};
}
