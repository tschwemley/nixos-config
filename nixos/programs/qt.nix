{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];
  # qt = {
  #   enable = true;
  #   platformTheme = "gtk2";
  #   style = "gtk2";
  # };
}
