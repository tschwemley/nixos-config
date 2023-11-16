{ vimPlugins, types }: types.submodule {
	pluginWithConfigType = {
		type = "lua";	
		plugin = vimPlugins.comment-nvim;
		config = "require('Comment').setup()";
	};
}
