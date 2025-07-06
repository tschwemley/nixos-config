vimPlugins:
with vimPlugins; {
  plugin = nvim-colorizer-lua;
  type = "lua";
  config =
    # lua
    ''
      require("colorizer").setup()
    '';
}
