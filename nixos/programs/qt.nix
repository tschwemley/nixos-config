{pkgs, ...}: {
  # TODO: maybe add ydotool and wtype somewhere if needed?
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];

  # qt = {
  #   enable = true;
  #   platformTheme = "gtk2";
  #   style = "gtk2";
  # };
}
