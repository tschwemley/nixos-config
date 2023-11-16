{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./colors.nix
    ./completion.nix
    ./db.nix
    ./debugging.nix
    ./formatters-parsers.nix
    ./lsp.nix
    ./navigation.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    # extraLuaConfig = ''
    #   require "schwem.keymap"
    #   require "schwem.helpers"
    #   require "schwem.options"
    #   require "schwem.plugins"
    # '';
    extraLuaPackages = [];
    plugins = with pkgs.vimPlugins; [
      # I don't know where to put these ones yet
      comment-nvim
      nvim-luadev
      toggleterm-nvim
      which-key-nvim

      # call the doctor, we diagnosing shit
      trouble-nvim
    ];
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile = {
    "nvim/lua".source = ../xdg-config/nvim/lua;
    "nvim/ftplugin".source = ../xdg-config/nvim/ftplugin;
  };
}
