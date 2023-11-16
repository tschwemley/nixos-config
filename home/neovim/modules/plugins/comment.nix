{ vimPlugins }: {
	type = "lua";	
	plugin = vimPlugins.comment-nvim;
	config = /* lua */ ''
		require('Comment').setup()
	'';
}
