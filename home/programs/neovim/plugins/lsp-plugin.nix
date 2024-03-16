{vimPlugins}:
with vimPlugins; {
  plugin = nvim-lspconfig;
  type = "lua";
  config =
    /*
    lua
    */
    ''
      local lspconfig = require('lspconfig')
    '';
}
