{pkgs, ...}: {
	xdg.configFile."nvim/after/ftplugin/oil.lua".text = 
		# lua
		''
			vim.keymap.set("n", "l", builtin.find_files)
			'';
}
