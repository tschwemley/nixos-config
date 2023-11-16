{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    location = "center";
    terminal = "wezterm";
    # xoffset = 1080;
  };

  home.packages = with pkgs; [rofi-rbw];
}
