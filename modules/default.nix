{ ... }: {
	flake.modules = {
		home = import ./home;
		nixos = import ./nixos;
	};
}
