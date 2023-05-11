{ inputs, ... }: 
let 
	mkSystem = configPath: inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
		# imports = [
			inputs.home-manager.nixosModule
			./modules/common.nix
		];
	};
in
{
	flake.nixosConfigurations = {
		office = mkSystem ./office.nix;
	};
}
