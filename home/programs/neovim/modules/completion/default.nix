{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    blink-cmp
    blink-compat # necessary for compat with any nvim-cmp plugins
    codecompanion-nvim

    # luasnip
    # nvim-cmp
    # cmp-buffer
    # cmp-cmdline
    # cmp-dap
    # cmp-nvim-lsp
    # cmp-path
    # cmp_luasnip
  ];

  xdg.configFile = {
    "nvim/after/plugin/completion.lua".source = ./completion.lua;
    # "nvim/after/plugin/completion.lua".source = ./completion.old.lua;
    # "nvim/after/plugin/luasnip.lua".source = ./luasnip.lua;
  };
}
