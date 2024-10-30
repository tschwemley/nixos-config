{
  imports = [
    # ./bitmagnet.nix
    ./nzbhydra2.nix
    ./qbittorrent-nox.nix
    ./sabnzbd
  ];

  users.groups.arr = {};
}
