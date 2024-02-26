{config, ...}: {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    runInUwsgi = true;
    settingsFile = config.sops.secrets.searxng.path;
  };

  networking.firewall.allowedTCPPorts = [8080];

  sops.secrets.searxng = {
    owner = config.users.users.uwsgi.name;
    group = config.users.users.uwsgi.group;
    mode = "0444";
    sopsFile = ./secrets.yaml;
  };
}
