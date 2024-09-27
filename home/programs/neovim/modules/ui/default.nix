{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    edgy-nvim
    noice-nvim
    # nvim-notify
  ];

  xdg.configFile."nvim/after/plugin/edgy.lua".source = ./edgy.lua;
  xdg.configFile."nvim/after/plugin/noice.lua".source = ./noice.lua;
}
# references:
#   - https://github.com/folke/edgy.nvim
