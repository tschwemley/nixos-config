{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    edgy-nvim
    lualine-nvim
    noice-nvim
    # nvim-notify
  ];

  xdg.configFile = {

    "nvim/after/plugin/edgy.lua".source = ./edgy.lua;
    "nvim/after/plugin/lines.lua".source = ./lines.lua;
    "nvim/after/plugin/noice.lua".source = ./noice.lua;
  };
}
# references:
#   - https://github.com/folke/edgy.nvim
