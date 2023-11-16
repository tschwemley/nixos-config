{pkgs, lib, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    extraLuaConfig = ''
      require "schwem.colorschemes"
      require "schwem.keymap"
      require "schwem.lsp"
      require "schwem.options"
      require "schwem.plugins"
    '';
    extraLuaPackages = [];
    plugins = with pkgs.vimPlugins; [
      comment-nvim
      gruvbox-material
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

      # completion plugins
      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
    ];
    withNodeJs = true;
    withPython3 = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile = {
    "nvim/lua".source = ../config/nvim/lua;
    #"nvim/init.lua".source = ./lua/init.lua;
    #"nvim/parser".source = "${parserDir}";
  };
}
