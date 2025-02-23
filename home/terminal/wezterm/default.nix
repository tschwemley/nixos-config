{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    # extraConfig = builtins.readFile ./wezterm.lua;
  };

  xdg.configFile."wezterm/".source = ./config;

  # home.sessionVariables = {
  #   TERMINFO_DIRS = "$TERMINFO_DIRS:$HOME/.nix-profile/share/terminfo";
  #   WSLENV = "TERMINFO_DIRS";
  # };
}
