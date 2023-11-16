{
  pkgs,
  lib,
  ...
}: 
let
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    extraLuaConfig = ''
      require "schwem.colorschemes"
      require "schwem.keymap"
      require "schwem.helpers"
      require "schwem.lsp"
      require "schwem.options"
      require "schwem.plugins"
    '';
    extraLuaPackages = [];
    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      comment-nvim
      lsp-zero-nvim
      luasnip
      lualine-nvim
      nnn-vim
      nvim-dap
      nvim-luadev
      nvim-lspconfig
      nvim-treesitter
      telescope-nvim
      toggleterm-nvim
      trouble-nvim
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
      which-key-nvim

      #colorschemes
      gruvbox-material

      # completion plugins
      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
    ];
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile = {
    "nvim/lua".source = ../xdg-config/nvim/lua;
    "nvim/ftplugin".source = ../xdg-config/nvim/ftplugin;
  };
}
