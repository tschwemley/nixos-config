{lib, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = lib.fileContents ../xdg-config/wezterm/wezterm.lua;
  };
}
