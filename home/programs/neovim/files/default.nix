{pkgs, ...}: {
	programs.neovim.plugins = [pkgs.vimPlugins.oil-nvim];
	xdg.configFile."nvim/after/plugin/files/oil.lua".source = ./lua/oil.lua;
}
