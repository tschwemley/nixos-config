{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; let
    mini-nvim = import ./mini.nix pkgs.vimPlugins;
    navbuddy = import ./navbuddy.nix pkgs.vimPlugins;
    nvim-sops = import ./nvim-sops.nix pkgs.vimPlugins;
    rest-nvim = import ./rest-nvim.nix pkgs.vimPlugins;
  in [
    mini-nvim
    navbuddy
    nvim-sops
    rest-nvim

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
