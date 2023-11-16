{ ... }: {
	flake.homeModules = {
		audio = import ./audio;
		desktop = import ./desktop;
		development = import ./development;
		gaming = import ./gaming;
		shell = import ./shell;
		terminal = import ./terminal;
	};
}
