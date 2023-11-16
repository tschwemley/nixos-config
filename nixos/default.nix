{ self, inputs, ... }: 
let 
	mkSystem = configPath: inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			inputs.home-manager.nixosModule
			./modules
			configPath
		];
	};
in
{
	flake.nixosConfigurations = {
		moltres = mkSystem ./hosts/moltres;
	};
}
