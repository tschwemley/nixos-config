{ pkgs, ... }:

{
	# import any modules that should be on every machine
	imports = [
		./bat.nix
		./terminal
		./neovim
	];


	home.packages = with pkgs; [
		nnn
	];
	
	# common options/programs to all home configurations
	#home.stateVersion = "22.11";
	home.stateVersion = "23.05";
}
