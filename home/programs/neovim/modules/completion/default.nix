{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    blink-cmp
    blink-compat # necessary for compat with any nvim-cmp plugins
    luasnip

    # TODO: determine which (if any) of these are necessary in the migration to Blink
    # nvim-cmp
    # cmp-buffer
    # cmp-cmdline
    # cmp-dap
    # cmp-nvim-lsp
    # cmp-path
    # cmp_luasnip
  ];

  xdg.configFile = {
    "nvim/after/plugin/blink.lua".source = ./blink.lua;
    "nvim/after/plugin/snippets".source = ./snippets;
  };
}
