{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bottles
    wineWowPackages.waylandFull
    winetricks

    # deps for various wine packages
    samba
  ];
}
