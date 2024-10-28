vimPlugins: {
  plugin = vimPlugins.rest-nvim - navbuddy;
  type = "lua";
  config = # lua
    ''
      require("telescope").load_extension("rest")
    '';
}
