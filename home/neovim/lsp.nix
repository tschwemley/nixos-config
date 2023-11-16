{pkgs, ...}: {
  home.packages = with pkgs; [
    gopls
	lua-lanaguage-server
    nixd
    nodePackages.intelephense
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
  ];

  programs.neovim = {
    extraLuaConfig = "require 'schwem.lsp'";
    plugins = with pkgs.vimPlugins; [
      lsp-zero-nvim
      nvim-lspconfig
      # TODO: remove these if unnecesasry
      #mason-nvim
      #mason-lspconfig-nvim
    ];
  };
}
