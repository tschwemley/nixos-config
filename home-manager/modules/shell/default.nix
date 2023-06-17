{ config, ... }: {
	imports = [
		./direnv.nix
		./starship.nix
		./zsh.nix { inherit config; }
	];
}
