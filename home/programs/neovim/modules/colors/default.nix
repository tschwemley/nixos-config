{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    everforest
    gruvbox-material
    gruvbox-nvim
    solarized-nvim
  ];

  xdg.configFile."nvim/after/plugin/colors.lua".source = ./colors.lua;
}
