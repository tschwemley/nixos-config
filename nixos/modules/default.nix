{ sops, pkgs, ... }:

{
	imports = [
		./direnv.nix
		./nix.nix
		sops.nixosModules.sops
	];

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		curl
		ripgrep
		wget
	];
}
