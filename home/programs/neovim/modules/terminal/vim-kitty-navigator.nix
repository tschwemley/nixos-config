{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-kitty-navigator
  ];

  xdg.configFile = {
    "kitty/get_layout.py".source = "${pkgs.vimPlugins.vim-kitty-navigator}/get_layout.py";
    "kitty/pass_keys.py".source = "${pkgs.vimPlugins.vim-kitty-navigator}/pass_keys.py";
  };
}
