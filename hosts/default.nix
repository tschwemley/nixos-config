{ ... }: {
	flake.nixosConfigurations = {
		office = { imports = [ ./office.nix ]; };
		k3s = { imports = [ ./k3s.nix ]; };
	};
}
