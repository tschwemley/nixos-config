{pkgs, ...}: let
  lsp-zero = with pkgs;
    vimUtils.buildVimPlugin {
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
  lsp-format-modifications = with pkgs;
    vimUtils.buildVimPlugin {
      pname = "lsp-format-modifications.nvim";
      version = "20230820";
      src = fetchFromGitHub {
        owner = "joechrisellis";
        repo = "lsp-format-modifications.nvim";
        rev = "006d4cd88f4f09fdc4375fcb75dd5b7d981a723b";
        sha256 = "sha256-eJmwvaKE/O7qeZjlUSYj6Iojn3yJH1wrGL3Tlc6V6V0=";
      };
      meta.homepage = "https://github.com/joechrisellis/lsp-format-modifications.nvim";
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
      lsp-format-modifications
      lsp-zero
      nvim-lspconfig
    ];
  };
}
