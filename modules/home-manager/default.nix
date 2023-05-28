{ home-manager, ... }:
let 
	homeManager = home-manager.nixosModule;
in
{
	inherit homeManager;
	
	home-manager.useGlobalPackages = true;
	home-manager.useUserPackages = true;
	imports = [
		{
			home.stateVersion = 23.05;
		}
	];
}
