{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		barrier
	];
}
