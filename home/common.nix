{ homeModules, pkgs, ... }: {
	imports = [
		homeModules.development
		homeModules.shell	
		homeModules.terminal
	];
}
