{vimPlugins, submodule, ...}: submodule {
  type = "lua";
  plugin = vimPlugins.comment-nvim;
  config = "require('Comment').setup()";
}
