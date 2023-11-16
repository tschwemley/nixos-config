{pkgs, ...}: {
	home.packages = with pkgs; [
		discord
		discordo # dicord terminal client
	];
}
