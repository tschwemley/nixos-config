{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    runInUwsgi = true;
    settingsFile = sops.secrets.searxng.path;
  };

  sops.secrets.searxng = {
    path = ./secrets.yaml;
  };
}
