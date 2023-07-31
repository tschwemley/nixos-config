{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "wezterm";
  };

  home.packages = with pkgs; [rofi-rbw];
}
