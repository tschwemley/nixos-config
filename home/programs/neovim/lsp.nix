{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      # bash
      bash-language-server

      # go
      golines
      gopls
      gotools

      # lua
      lua-language-server

      # markdown
      marksman

      # nix
      nixd

      openscad-lsp

      # php
      intelephense
      phpactor

      # python
      basedpyright

      # web
      vscode-css-languageserver
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };
}
