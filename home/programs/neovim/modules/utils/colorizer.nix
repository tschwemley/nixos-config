vimPlugins:
with vimPlugins; {
  plugin = nvim-colorizer-lua;
  type = "lua";
  config =
    # lua
    ''
      require("colorizer").setup({
        names_custom = {
          aqua = "#8ec07c",
          blue = "#83a598",
          green = "#b8bb26",
          orange = "#fe8019",
          purple = "#d3869b",
          red = "#fb4934",
          yellow = "#fabd2f",
        },
      })
    '';
}
