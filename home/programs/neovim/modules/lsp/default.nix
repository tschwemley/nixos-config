{
  self,
  pkgs,
  ...
}: let
  otter = import ./otter.nix pkgs.vimPlugins;

  packages = {
    lsp = with pkgs; [
      lua-language-server
      nil # nix
      nodePackages.bash-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      phpactor
      python313Packages.python-lsp-server
      typescript
      yaml-language-server

      # htmx-lsp
      # marksman
      # nixd
    ];

    linters = with pkgs; [
      deadnix
      prettierd
      statix
    ];

    formatting = with pkgs; [
      alejandra
      nixfmt-rfc-style
      stylua
    ];

    utils = with pkgs; [
      json2go
      sqlfluff
      taplo
    ];
  };

  plugins = with pkgs.vimPlugins; {
    formatting = [
      none-ls-nvim
    ];
    lsp = [
      otter
      nvim-lspconfig
    ];
  };

  inherit (self) lib;
in {
  imports = [./go.nix];

  programs.neovim = {
    extraPackages = lib.flattenAttrs packages;
    plugins = lib.flattenAttrs plugins;
  };

  xdg.configFile = {
    # "nvim/lua/lspconfigs".source = ./lspconfigs;

    # TODO: consolidate this once confirming working a-ok
    "nvim/after/lsp/intelephense.lua".source = ./lspconfigs/intelephense.lua;
    "nvim/after/lsp/lua_ls.lua".source = ./lspconfigs/lua_ls.lua;

    "nvim/after/plugin/lsp/keymaps.lua".source = ./keymaps.lua;
    "nvim/after/lsp/init.lua".source = ./lsp.lua;
    "nvim/after/plugin/lsp/none_ls.lua".source = ./none_ls.lua;
  };
}
