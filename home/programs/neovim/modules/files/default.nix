{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    lazydev-nvim
    taskwarrior3
  ];

  xdg.configFile = {
    "nvim/after/plugin/filetypes.lua".source = ./filetypes.lua;
    "nvim/after/ftplugin".source = ./ftplugin;

    "nvim/syntax/tid.vim".source = ./syntax/tid.vim;
  };
}
