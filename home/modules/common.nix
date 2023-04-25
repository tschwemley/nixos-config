{ pkgs, ... }:

{
	# import any modules that should be on every machine
	imports = [
		./bat.nix
		./direnv.nix
		./neovim
		./wezterm.nix
		./zsh.nix
	];


	home.packages = with pkgs; [
		nnn
	];
	
	# common options/programs to all home configurations
	home.stateVersion = "22.11";
}
