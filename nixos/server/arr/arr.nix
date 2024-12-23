{
  imports = [./servarr];

  services = {
    radarr.enable = true;
  };

  systemd.tmpfiles.rules = ["d /storage/media 0774 root arr - -"];

  users.users = {
    radarr.extraGroups = ["arr"];
  };
}
