{ pkgs, ... }: 
{
	imports = [ ./. ];

	home = {
		username = "k3s";
		homeDirectory = "/home/k3s";
		stateVersion = "23.11";
	};
}
