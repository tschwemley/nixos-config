{pkgs, ...}: {
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
      lsp-zero-nvim
      lspsaga-nvim
      nvim-lspconfig
    ];
  };

  xdg.configFile."language-servers/haxe-server.js" = {
    source = "${pkgs.vimPlugins.coc-haxe.outPath}/bin/server.js";
  };
}
