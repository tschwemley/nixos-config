{ pkgs, ... }:
{
  programs.neovim = with pkgs; {
    extraPackages = [
      nixd
			nodePackages.intelephense
    ];

    plugins = [
      vimPlugins.nvim-lspconfig
    ];
  };

  xdg.configFile = {
    "nvim/lsp/intelephense.lua".source = ./lua/servers/intelephense.lua;
  };
}
