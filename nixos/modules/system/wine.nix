{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    winetricks

    # deps for various wine packages
    samba
  ];
}
