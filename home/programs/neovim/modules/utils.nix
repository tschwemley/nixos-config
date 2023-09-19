{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    rsync-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
