{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
  ];
  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk3";
  };
}
