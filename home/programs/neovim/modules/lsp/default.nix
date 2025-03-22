{
  self,
  pkgs,
  ...
}: let
  otter = import ./otter.nix pkgs.vimPlugins;

  packages = {
    lsp = with pkgs; [
      htmx-lsp
      lua-language-server
      marksman
      nil
      # nixd
      nodePackages.bash-language-server
      nodePackages.intelephense
      nodePackages.typescript-language-server
      phpactor
      typescript
      yaml-language-server
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

      lazydev-nvim
      nvim-lspconfig
    ];
    # utility = [
    #   nvim-web-devicons
    # ];
  };

  inherit (self) lib;
in {
  imports = [./go.nix];

  programs.neovim = {
    extraPackages = lib.flattenAttrs packages;
    plugins = lib.flattenAttrs plugins;
  };

  xdg.configFile = {
    "nvim/lua/lspconfigs".source = ./lspconfigs;

    "nvim/after/plugin/lsp/keymaps.lua".source = ./keymaps.lua;
    "nvim/after/plugin/lsp/lsp.lua".source = ./lsp.lua;
    "nvim/after/plugin/lsp/none_ls.lua".source = ./none_ls.lua;
  };
}
