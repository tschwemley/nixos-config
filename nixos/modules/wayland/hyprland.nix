{pkgs, ...}: {
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];
}
