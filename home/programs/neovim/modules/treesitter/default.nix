{ pkgs, ... }:
let
  treesitter = import ./treesitter.nix pkgs;
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    treesitter
    nvim-treesitter-textobjects
  ];

  xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./treesitter.lua;
}
