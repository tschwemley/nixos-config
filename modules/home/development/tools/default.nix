{ homeManager, pkgs, ... }: {
	# home-manager.sharedModules = [
	# 	./bat.nix
	# 	./git.nix # TODO: when adding more than my users this should be moved from sharedModules
	# ];
	imports = [
		./bat.nix
		./git.nix
		./ripgrep.nix
	];

	environment.systemPackages = with pkgs; [
		curl
		wget
	];
}
