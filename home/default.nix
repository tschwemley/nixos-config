{ self, inputs, config, ... }:
let 
	mkHomeConfiguration = extraMods: inputs.home-manager.lib.homeManagerConfiguration {
		pkgs = inputs.nixpkgs;
		
		modules = [
			./modules/common.nix
		] ++ extraMods;
	};
in
{
  flake = {
	  homeConfigurations = {
		kubernetes = {
			agent = {};
			server = {};
		};

		personal = mkHomeConfiguration [
			{
				home.username= "schwem";
				home.homeDirectory= "/home/schwem";
			}
		];
		
		work = {};
	  };
	  
	  nixosModules = {
        home-manager = inputs.home-manager.nixosModule {
        	home.stateVersion = "22.11";
        	home.useGlobalPkgs = true;
        	home.useUserPackages = true;
        };
	  };
  };
}
