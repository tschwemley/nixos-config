{ self, ... }:
{
	imports = [
		self.nixosModules.development
		self.nixosModules.home-manager
		self.nixosModules.programs.common
	];

	environment.systemPackages = with pkgs; [
		curl
		ripgrep
		wget
	];
}
