{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    wineWow64Packages.waylandFull
    winetricks

    # deps for various wine packages
    samba
  ];
}
