# {pkgs, ...}: {
{
  # programs.neovim.plugins = with pkgs.vimPlugins; [];

  xdg.configFile."nvim/after/plugin/editing/mini-pairs.lua".text = "require('mini.pairs').setup()";
}
