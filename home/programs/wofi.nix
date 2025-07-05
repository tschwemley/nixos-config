{pkgs, ...}: {
  home.packages = with pkgs; [
    wofi
    wofi-emoji
    wofi-power-menu
  ];
}
