{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
