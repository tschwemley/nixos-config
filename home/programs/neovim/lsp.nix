{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      nixd
      nodePackages.intelephense
      superhtml
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };
}
