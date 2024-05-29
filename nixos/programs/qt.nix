{pkgs, ...}: {
  # TODO: maybe add ydotool and wtype somewhere if needed?
  environment.systemPackages = with pkgs; [
    # kdePackages.qtwayland
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];

  # qt = {
  #   enable = true;
  #   platformTheme = "gtk2";
  #   style = "gtk2";
  # };
}
