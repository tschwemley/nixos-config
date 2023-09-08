{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "wezterm";
  };

  home.packages = with pkgs; [rofi-rbw];
}
