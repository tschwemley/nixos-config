{ pkgs, ... }:
let
  packages = {
    lsp = with pkgs; [
      htmx-lsp
      lua-language-server
      gopls
      nil
      nodePackages.bash-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      typescript
      sqls
    ];

    linters = with pkgs; [
      deadnix
      golangci-lint
      statix
    ];

    formatting = with pkgs; [
      # alejandra
      golangci-lint
      golines
      gotools
      nixfmt-rfc-style
      stylua
    ];

    utils = with pkgs; [
      json2go
      taplo
    ];
  };

  plugins = with pkgs.vimPlugins; {
    formatting = [
      none-ls-nvim
    ];
    lsp = [ nvim-lspconfig ];
    utility = [
      nvim-web-devicons
    ];
  };

  # TODO: make this an extension of lib at the flake level
  flatten = attrset: builtins.concatLists (builtins.attrValues attrset);
in
{
  programs.neovim = {
    extraPackages = flatten packages;
    plugins = flatten plugins;
  };

  xdg.configFile = {
    "nvim/after/plugin/lsp/keymaps.lua".source = ./keymaps.lua;
    "nvim/after/plugin/lsp/lsp.lua".source = ./lsp.lua;
    "nvim/after/plugin/lsp/none_ls.lua".source = ./none_ls.lua;
  };
}
