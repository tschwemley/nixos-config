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
  # Configuration common to all Linux systems
  flake = {
    users = {
    	schwem = mkUserModule "schwem" [
			self.homeModules.xServer
		];
    };
  };
}
