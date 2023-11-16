{
  pkgs,
  lib,
  ...
}: {
  imports = [
	  ./lsp.nix
  ];

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
      # bars and lines; you know - the fun stuff
      bufferline-nvim
      lualine-nvim

      # call the doctor, we diagnosing shit
      trouble-nvim

      comment-nvim
      nnn-vim
      nvim-dap
      nvim-luadev
      nvim-treesitter
      telescope-nvim
      toggleterm-nvim
      which-key-nvim

      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      luasnip

      # d b rockin dat dadbod
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion

      # pretty things
      gruvbox-material
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
