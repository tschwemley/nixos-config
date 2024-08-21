{pkgs, ...}: let
  packages = {
    lsp = with pkgs; [
      dprint
      htmx-lsp
      lua-language-server
      nil
      nodePackages.bash-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      typescript
      sqls
    ];

    formatting = with pkgs; [
      alejandra
      golangci-lint
      golines
      gopls
      gotools
      revive # go linter
      stylua
    ];

    utils = with pkgs; [
      json2struct
    ];
  };

  plugins = with pkgs.vimPlugins; {
    formatting = [
      none-ls-nvim
    ];
    lsp = [nvim-lspconfig];
    utility = [
      nvim-web-devicons
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

    "nvim/after/plugin/lsp/languages/go.lua".source = ./languages/go.lua;
  };
}
