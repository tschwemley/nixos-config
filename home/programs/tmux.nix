{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];
    mouse = true;
    shortcut = "b";
    terminal = "wezterm";
  };
}
