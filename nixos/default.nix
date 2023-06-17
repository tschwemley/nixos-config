{ inputs, withSystem, pkgs, ... }: 
let
	mkSystem = configPath: systemString: withSystem systemString ({system, ... }: inputs.nixpkgs.lib.nixosSystem {
		inherit system;
		
		specialArgs = {
			inherit inputs;		
		};
		modules = [
			./modules
			configPath
		];
	});
in
{
	flake = {
		nixosConfigurations = {
			moltres = mkSystem ./hosts/moltres "x86_64-linux";
		};
	};
}
