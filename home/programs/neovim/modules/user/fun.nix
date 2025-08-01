# NOTE: right now this file is only for supercollider. I may keep this strucutre or move to audio focus later
{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    scnvim
  ];

  xdg.configFile."nvim/after/plugin/fun.lua".source = ./fun.lua;
}
