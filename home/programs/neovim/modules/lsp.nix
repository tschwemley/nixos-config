{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    gopls
    lua-language-server
    nil
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
