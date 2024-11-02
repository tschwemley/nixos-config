{
  imports = [
    ./kitty
    ./shell
    # ./wezterm
  ];

  # TODO: move this when I figure out how the fuck I'm organizing terminal/cli/shell/whatever the fuck terminology
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
