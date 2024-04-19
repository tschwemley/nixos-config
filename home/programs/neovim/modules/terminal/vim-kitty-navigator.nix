{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-kitty-navigator
  ];

  # xdg.configFile."kitty/pass_keys.py".source =
}
