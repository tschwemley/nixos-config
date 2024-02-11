{config, ...}: {
  imports = [./virtualhost.nix];

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    runInUwsgi = true;
    settingsFile = config.sops.secrets.searxng.path;
    # uwsgiConfig = {
    #   disable-logging = true;
    #   socket = "/run/searx/searx.sock";
    #   chmod-socket = "660"; # allows searx group rw
    # };
  };

  sops.secrets.searxng = {
    owner = config.users.users.uwsgi.name;
    group = config.users.users.uwsgi.group;
    mode = "0444";
    sopsFile = ./secrets.yaml;
  };
}
