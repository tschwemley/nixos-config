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
    gitsigns-nvim
    nnn-vim
    nvim-ufo
    plenary-nvim
    refactoring-nvim
    vim-abolish
    vim-fugitive
    vim-speeddating
    vim-surround
  ];

  xdg.configFile = {
    "nvim/after/plugin/git.lua".source = ./git.lua;
    # "nvim/after/plugin/mini.lua".source = ./mini.lua;
    "nvim/after/plugin/nnn.lua".source = ./nnn.lua;
    "nvim/after/plugin/refactoring.lua".source = ./refactoring.lua;
    "nvim/after/plugin/ufo.lua".source = ./ufo.lua;
  };
}
