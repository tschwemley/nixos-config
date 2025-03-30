{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    everforest
    gruvbox-nvim
  ];

  xdg.configFile."nvim/after/plugin/colors.lua".source = ./colors.lua;
}
