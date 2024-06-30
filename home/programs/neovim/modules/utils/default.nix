{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    dressing-nvim
    mini-nvim
    neogit-nightly
    nnn-vim
    nvim-ufo
    refactoring-nvim
    vim-abolish
    vim-surround
  ];

  xdg.configFile."nvim/after/plugin/mini-clue.lua".source = ./mini-clue.lua;
  xdg.configFile."nvim/after/plugin/neogit.lua".source = ./neogit.lua;
  xdg.configFile."nvim/after/plugin/nnn.lua".source = ./nnn.lua;
  xdg.configFile."nvim/after/plugin/refactoring.lua".source = ./refactoring.lua;
  xdg.configFile."nvim/after/plugin/ufo.lua".source = ./ufo.lua;
}
