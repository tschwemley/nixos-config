{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.lazydev-nvim];
  xdg.configFile = {
    "nvim/after/plugin/filetypes.lua".source = ./filetypes.lua;
    "nvim/after/ftplugin".source = ./ftplugin;

    "nvim/syntax/tid.vim".source = ./syntax/tid.vim;
  };
}
