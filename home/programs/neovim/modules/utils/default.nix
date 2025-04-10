{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # TODO: revisit navbuddy when time... looks interesting
    # navbuddy # old config: navbuddy = import ./navbuddy.nix pkgs.vimPlugins;

    direnv-vim
    dressing-nvim
    nnn-vim
    nvim-ufo
    plenary-nvim # most plugins install this as a dependency; I'm including for it's log method
    vim-abolish
    vim-speeddating
    vim-startuptime
    # vim-surround
  ];

  xdg.configFile = {
    "nvim/after/plugin/nnn.lua".source = ./nnn.lua;
    "nvim/after/plugin/ufo.lua".source = ./ufo.lua;
  };
}
