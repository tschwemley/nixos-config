{ vimPlugins, submodule}: 
let
	comment = import ./comment.nix { inherit vimPlugins; };
in
{
	programs.neovim.plugins = with submodule; [
		comment
	];
}
