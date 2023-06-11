{ inputs, ... }:
{
	imports = [
		inputs.home-manager.nixosModule {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
		}
	];
}
