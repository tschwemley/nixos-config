{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    plenary-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
