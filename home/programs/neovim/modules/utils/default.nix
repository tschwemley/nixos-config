{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    dressing-nvim
    gitsigns-nvim
    mini-nvim
    nnn-vim
    nvim-spectre
    nvim-ufo
    refactoring-nvim
    rest-nvim
    vim-abolish
    vim-fugitive
    vim-speeddating
    vim-surround
    vlog
  ];

  xdg.configFile = {
    "nvim/after/plugin/git.lua".source = ./git.lua;
    "nvim/after/plugin/mini-clue.lua".source = ./mini-clue.lua;
    "nvim/after/plugin/nnn.lua".source = ./nnn.lua;
    "nvim/after/plugin/refactoring.lua".source = ./refactoring.lua;
    "nvim/after/plugin/spectre.lua".source = ./spectre.lua;
    "nvim/after/plugin/ufo.lua".source = ./ufo.lua;
  };
}
