{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qt6ct
    libsForQt5.qt5ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    # platformTheme.name = "gtk3";
    # style.name = "adwaita";
  };
}
