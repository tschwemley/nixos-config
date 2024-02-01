{lib, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = lib.fileContents ./wezterm.lua;
  };

  home.sessionVariables = {
    TERMINFO_DIRS = "$TERMINFO_DIRS:$HOME/.nix-profile/share/terminfo";
    WSLENV = "TERMINFO_DIRS";
  };
}
