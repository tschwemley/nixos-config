{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    glow-nvim
    # go-nvim
  ];

  xdg.configFile."nvim/after/plugin/filetypes.lua".source = ./filetypes.lua;
  xdg.configFile."nvim/after/ftplugin".source = ./ftplugin;
}
