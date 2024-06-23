{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bottles # another wineprefix manager. supposedly easy to use
    wineWowPackages.waylandFull
    winetricks

    # deps for various wine packages
    samba
  ];
}
