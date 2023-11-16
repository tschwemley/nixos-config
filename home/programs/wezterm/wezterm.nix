{lib, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = lib.fileContents ./wezterm.lua;
  };
}
