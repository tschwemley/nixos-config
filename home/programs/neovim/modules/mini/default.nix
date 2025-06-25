{ pkgs, ... }:
{
  # REF: https://github.com/echasnovski/mini.nvim?tab=readme-ov-file#modules
  programs.neovim.plugins = [ pkgs.vimPlugins.mini-nvim ];

  xdg.configFile = {
    "nvim/after/plugin/mini/appearance.lua".source = ./appearance.lua;
    "nvim/after/plugin/mini/clue.lua".source = ./clue.lua;
    "nvim/after/plugin/mini/text_edit.lua".source = ./text_edit.lua;
  };
}
