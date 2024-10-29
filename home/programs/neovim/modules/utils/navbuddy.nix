vimPlugins: {
  plugin = vimPlugins.nvim-navbuddy;
  type = "lua";
  config =
    /*
    lua
    */
    ''
      require('nvim-navbuddy').setup({ lsp = { auto_attach = true } })
    '';
}
