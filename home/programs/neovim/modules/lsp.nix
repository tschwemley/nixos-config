{pkgs, ...}: {
  home.packages = with pkgs; [
    gopls
    lua-language-server
    nixd
    nodePackages.intelephense
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lsp-zero-nvim
      nvim-lspconfig
    ];
  };
}
