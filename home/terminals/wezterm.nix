{lib, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = lib.fileContents ../config/wezterm.lua;
  };
}
