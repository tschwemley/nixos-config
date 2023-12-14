{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    rest-nvim
    # (import ../plugins/rest-nvim {inherit (pkgs) vimPlugins;})
    toggleterm-nvim
    which-key-nvim
  ];
}
