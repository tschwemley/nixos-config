{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    everforest
    gruvbox-nvim
  ];
}
