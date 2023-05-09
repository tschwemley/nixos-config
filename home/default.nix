{ self, ... }:

{
	flake.homeConfigurations = {
		k3s = import ./k3s.nix;
		personal = import ./desktop.nix;
		work = import ./work.nix;
	};
}
