{
  imports = [
    # ./bitmagnet.nix
    ./nzbhydra2.nix
    ./qbittorrent-nox.nix
    ./sabnzbd
    ./servarr
  ];

  systemd.tmpfiles.rules = ["d /storage/downloads 0770 root arr - -"];

  users.groups.arr = {};
}
