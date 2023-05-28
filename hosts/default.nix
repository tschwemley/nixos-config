{ self, inputs, ... }: 
let 
	mkSystem = configPath: inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			inputs.home-manager.nixosModule
			inputs.sops.nixosModules.sops
			configPath
		];
	};
in
{
	flake.nixosConfigurations = {
		charizard = mkSystem ./charizard;
		moltres = mkSystem ./moltres;
	};
}
