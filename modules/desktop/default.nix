{ self, ... }:
let 
	importedModules = { 
		nvidia = import ./nvidia.nix; 
		steam = import ./steam.nix;
	};
in
{
	flake.modules.desktop = importedModules;
}
