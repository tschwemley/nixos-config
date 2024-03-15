{vimPlugins}:
with vimPlugins; {
  plugin = nvim-lspconfig;
  config =
    /*
    lua
    */
    ''
      local lspconfig = require('lspconfig')
    '';
}
