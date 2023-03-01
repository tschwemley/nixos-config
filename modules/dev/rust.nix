{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		pkgs.cargo
		pkgs.rustc
		pkgs.rustfmt
	];
}
