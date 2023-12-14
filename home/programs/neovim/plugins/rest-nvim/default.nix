{vimPlugins}:
with vimPlugins; {
  plugin = rest-nvim;
  config = builtins.readFile ./config.lua;
}
