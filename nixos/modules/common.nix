{ pkgs, ... }:
{
	imports = [
		./fonts.nix
		./nix.nix
	];

	environment.systemPackages = with pkgs; [
		cargo
		curl
		go
		mullvad
		ripgrep
		navi
		nodejs
		rustc
		wget
	];
}
