{ pkgs, lib, ... }: {
	imports = [
		./colors.nix
		./completion.nix
		./db.nix
		./debugging.nix
		./formatters-parsers.nix
		./lsp.nix
		./navigation.nix
		(import ./plugins {inherit (pkgs) vimPlugins; inherit (lib.types) submodule; })
	];	
}
