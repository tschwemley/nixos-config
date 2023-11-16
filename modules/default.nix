{ ... }:
{
	# imports = [
	# 	./direnv.nix
	# 	./nix.nix
	# 	sops.nixosModules.sops
	# ];
	nixosModules = let
		development = import ./development;
		homeManager = import ./home-manager;
	in {
		inherit development homeManager;
	};
}
