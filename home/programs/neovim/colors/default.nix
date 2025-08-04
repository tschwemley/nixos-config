{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    everforest
    gruvbox-nvim
  ];

  xdg.configFile."nvim/after/colors".source = ./lua;
}
