{ ... }: {
	nixosModules.audio = { ... }: {
		imports = [
			./bluetooth.nix
		];
	};
}
