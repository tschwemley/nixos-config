{pkgs, ...}: {
  imports = [./mini-visits.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; let
    navbuddy = import ./navbuddy.nix pkgs.vimPlugins;
    rest-nvim = import ./rest-nvim.nix pkgs.vimPlugins;
  in [
    navbuddy
    rest-nvim

    direnv-vim
    dressing-nvim
    gitsigns-nvim
    nnn-vim
    nvim-ufo
    refactoring-nvim
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
    "nvim/after/plugin/ufo.lua".source = ./ufo.lua;
  };
}
