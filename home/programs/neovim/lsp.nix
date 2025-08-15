{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      nixd
      nodePackages.intelephense
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  }; 
}
