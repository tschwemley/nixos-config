{ vimPlugins, submodule}: 
let
	comment = import ./comment.nix { inherit vimPlugins; };
in
{
	plugins = with submodule; [
		comment
	];
}
