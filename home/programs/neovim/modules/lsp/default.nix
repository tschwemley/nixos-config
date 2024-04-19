{pkgs, ...}: let
  packages = {
    lsp = with pkgs; [
      gopls
      lua-language-server
      nixd
      nodePackages.intelephense
    ];

    formatting = with pkgs; [
      alejandra
      gotools
      stylua
    ];
  };

  plugins = with pkgs.vimPlugins; {
    formatting = [
      none-ls-nvim
    ];
    lsp = [nvim-lspconfig];
    snippets = [luasnip];

    utility = [
      nvim-web-devicons
      trouble-nvim
    ];
  };

  # TODO: make this an extension of lib at the flake level
  flatten = attrset: builtins.concatLists (builtins.attrValues attrset);
in {
  programs.neovim = {
    extraPackages = flatten packages;
    plugins = flatten plugins;
  };

  xdg.configFile = {
    "nvim/after/plugin/lsp/keymaps.lua".source = ./keymaps.lua;
    "nvim/after/plugin/lsp/lsp.lua".source = ./lsp.lua;
    "nvim/after/plugin/lsp/null_ls.lua".source = ./null_ls.lua;
    "nvim/after/plugin/lsp/trouble.lua".source = ./trouble.lua;
  };
}
