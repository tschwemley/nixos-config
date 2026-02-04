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

      # php
      nodePackages.intelephense
      phpactor

      # python
      basedpyright

      # web
      superhtml
      vscode-css-languageserver
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };

  # sops.secrets =
  #   let
  #     mkSecret = key: {
  #       inherit key;
  #       sopsFile = "${self}/secrets/home/neovim.yaml";
  #     };
  #
  #   in
  #   {
  #     intelephense_license = mkSecret "intelephense_license";
  #     openrouter_nvim_api_key = mkSecret "openrouter_api_key";
  #   };
}
