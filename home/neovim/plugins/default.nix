{ vimPlugins, submodule}: 
let
	comment = import ./comment.nix { inherit submodule vimPlugins; };
in
{
	plugins = [
		comment
	];
}
