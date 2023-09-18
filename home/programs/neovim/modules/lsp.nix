{pkgs, ...}: let
  lsp-zero = with pkgs;
    vimUtils.buildVimPluginFrom2Nix {
      pname = "lsp-zero.nvim";
      version = "3.x";
      src = fetchFromGitHub {
        owner = "VonHeikemen";
        repo = "lsp-zero.nvim";
        rev = "53068d66f0313ac7c496e0b04f1f80169ee7980d";
        sha256 = "sha256-nJ0w4SO616RRUbFky+SH2deGh1uuIzF03QmlqdoIgxY=";
      };
      meta.homepage = "https://github.com/VonHeikemen/lsp-zero.nvim/";
    };
in {
  programs.neovim = {
    extraPackages = with pkgs; [
      alejandra
      gopls
      lua-language-server
      nil
      nodePackages.intelephense
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lsp-zero
      nvim-lspconfig
    ];
  };
}
