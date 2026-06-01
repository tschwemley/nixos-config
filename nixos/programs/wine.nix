{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wine-wayland
    winetricks

    wine64
    wine64Packages.waylandFull

    # wineWow64Packages.waylandFull

    # deps for various wine packages
    samba
  ];
}
