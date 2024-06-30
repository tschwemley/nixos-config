{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    edgy-nvim
    firenvim
  ];

  xdg.configFile."nvim/after/plugin/edgy.lua".source = ./edgy.lua;
  xdg.configFile."nvim/after/plugin/firenvim.lua".source = ./firenvim.lua;
}

# references:
#   - https://github.com/folke/edgy.nvim
#   - https://github.com/glacambre/firenvim
