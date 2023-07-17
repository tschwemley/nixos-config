{ vimPlugins, submodule}: 
let
	comment = import ./plugins/comment.nix { inherit vimPlugins; };
in
{
	plugins = with submodule; [
		comment
	];
}
