{ ... }: {
	flake.homeConfigurations = {
		desktop = import ./desktop.nix;
		k3s = import ./k3s.nix;
		work = import ./work.nix;
	};
}
