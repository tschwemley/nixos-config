{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		firefox-unwrapped
	];
}
