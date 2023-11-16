{ inputs, self, withSystem, ... }: 
let 
	commonModules = [
		self.nixosModules.homeManager
		self.nixosModules.services #TODO: this is too broad and should probably be split
		self.nixosModules.system
		inputs.sops.nixosModules.sops
		inputs.disko.nixosModules.disko
	];
	
	mkSystem = configPath: withSystem "x86_64-linux" ({system, ... }: inputs.nixpkgs.lib.nixosSystem {
		inherit system ;
		
		modules = [
			configPath
		] ++ commonModules;
	});
in
{
	flake.nixosConfigurations = {
		moltres = mkSystem ./moltres;
	};
}
