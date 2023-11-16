{ ... }: 
{
	audio = import ./audio;
	boot = import ./boot;
	common = import ./common.nix;
	dev = import ./dev;
	graphical = import ./graphical;
	gaming = import ./gaming.nix;
	nix = import ./nix.nix;
	openssh = import ./openssh.nix;
	windowManagers = import ./winow-managers;
}
