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
  yaml-companion = with pkgs;
    vimUtils.buildVimPlugin {
      pname = "yaml-companion.nvim";
      version = "2023-03-03";
      src = fetchFromGitHub {
        owner = "someone-stole-my-name";
        repo = "yaml-companion.nvim";
        rev = "4de1e1546abc461f62dee02fcac6a02debd6eb9e";
        sha256 = "sha256-BmX7hyiIMQfcoUl09Y794HrSDq+cj93T+Z5u3e5wqLc=";
      };
      meta.homepage = "https://github.com/someone-stole-my-name/yaml-companion.nvim";
    };
in {
  programs.neovim = {
    extraPackages = with pkgs; [
      alejandra
      gopls
      haxe
      lua-language-server
      nil
      nodePackages.intelephense
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lsp-zero
      lspsaga-nvim
      nvim-lspconfig
      yaml-companion
    ];
  };

  xdg.configFile."language-servers/haxe-server.js" = {
    source = "${pkgs.vimPlugins.coc-haxe.outPath}/bin/server.js";
  };
}
