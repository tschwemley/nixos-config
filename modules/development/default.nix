{ ... }: {
	direnv = import ./direnv.nix;
	git = import ./git.nix;

	all = {
		imports = [
			./direnv.nix
			./git.nix
		];
	}
}
