{
	xdg.configFile."nvim/after/ftplugin/php.lua".text = 
		# lua
		''
			vim.bo.tabstop = 4;
			vim.bo.shiftwidth = 4;
			vim.bo.expandtab = false;
			vim.bo.softtabstop = 4;

			vim.lsp.enable('intelephense')
		'';
}
