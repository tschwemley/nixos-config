{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # TODO: revisit navbuddy when time... looks interesting
    # navbuddy # old config: navbuddy = import ./navbuddy.nix pkgs.vimPlugins;

    direnv-vim
    dressing-nvim
    nnn-vim
    nvim-ufo
    plenary-nvim # most plugins install this as a dependency; I'm including for it's log method
    refactoring-nvim
    vim-abolish
    vim-speeddating
    vim-surround
  ];

  xdg.configFile = {
    # "nvim/after/plugin/mini.lua".source = ./mini.lua;
    "nvim/after/plugin/nnn.lua".source = ./nnn.lua;
    "nvim/after/plugin/refactoring.lua".source = ./refactoring.lua;
    "nvim/after/plugin/ufo.lua".source = ./ufo.lua;
  };
}
