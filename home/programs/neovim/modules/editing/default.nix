{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    boole-nvim
  ];

  xdg.configFile."nvim/after/plugin/boole.lua".text = # lua
    ''
      require("boole").setup()
    '';
}
