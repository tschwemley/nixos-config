{ vimPlugins }: {
	type = "lua";	
	plugin = vimPlugins.better-escape-nvim;
	config = "require('better-escape').setup()";
}
