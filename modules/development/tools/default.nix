{ pkgs, ... }: {
	imports = [
		./bat.nix
		./git.nix
	];
	
	#TODO: split?
	environment.systemPackages = with pkgs; [
		curl
		ripgrep
		wget
	];
}
