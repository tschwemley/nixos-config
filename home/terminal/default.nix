{
  imports = [
    ./kitty
    ./shell
    # ./wezterm
  ];

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
