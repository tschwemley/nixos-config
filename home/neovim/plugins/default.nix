{ vimPlugins, submodule}: 
let
	comment = import ./comment.nix { inherit vimPlugins; };
in
with submodule; [
	comment
]
