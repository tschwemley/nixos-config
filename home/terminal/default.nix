{
  imports = [
    ./kitty
    ./shell
    ./wezterm

    ./yazi.nix
  ];

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
