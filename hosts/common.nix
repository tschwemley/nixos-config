{ self, ... }:
{
	imports = [
		self.nixosModules.development
		self.nixosModules.home-manager
		self.nixosModules.programs.common
	];
	
  nixpkgs.config.allowUnfree = true;


	environment.systemPackages = with pkgs; [
		curl
		ripgrep
		wget
	];
}
