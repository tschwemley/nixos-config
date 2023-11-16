{lib, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = lib.fileContents ../xdg-config/wezterm/wezterm.lua;
  };
}
