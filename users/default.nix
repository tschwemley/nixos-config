{ self, inputs, config, ... }:
let
  mkUserModule = name: extraModules: {
    imports = [ 
		./${name}.nix
	];
	
    users.users.${name}.isNormalUser = true;
    home-manager.users.${name} = {
      imports = [
        self.homeModules.common
        #../home/git.nix
      ] ++ extraModules;
    };
  };
in
{
  flake = {
    users = {
    	cloud = {
			lux = mkUserModule "lux" [
			];
		};		
		
    	pcs = mkUserModule "schwem" [
			self.homeModules.xServer
		];
    };
  };
}
