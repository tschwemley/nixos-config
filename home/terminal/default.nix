{
  imports = [
    ./shell
    ./wezterm

    ./yazi.nix
  ];

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
