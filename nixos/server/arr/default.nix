{
  imports = [
    ./bitmagnet.nix
    ./nzbhydra2.nix
    ./qbittorrent.nix
    ./sabnzbd
  ];

  users.groups.arr = { };
}
