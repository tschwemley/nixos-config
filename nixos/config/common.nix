{ pkgs, ... }:

{
	imports = [
		./dev/direnv.nix
		./disks.nix
		./nix.nix
	];
	
  nixpkgs.config.allowUnfree = true;


	environment.systemPackages = with pkgs; [
		curl
		ripgrep
		wget
	];
}
