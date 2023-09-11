{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    gitsigns-nvim
    neogit
  ];
}
