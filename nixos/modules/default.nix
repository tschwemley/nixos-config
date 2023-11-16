{ inputs, pkgs, ... }: 
{
	imports = [
		inputs.home-manager.nixosModule { home-manager.useGlobalPkgs = true; }	
		inputs.sops.nixosModules.sops
		inputs.disko.nixosModules.disko
	];
	
	environment.systemPackages = with pkgs; [
		curl
		git
		neovim
		wget
	];	
	
	services.openssh.enable = true;
}
