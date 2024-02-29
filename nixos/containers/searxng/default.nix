{config, ...}: {
  imports = [./virtualhost.nix];

  # users.users.uwsgi.group = "uwsgi";

  sops.secrets.searxng = {
    # owner = config.users.users.uwsgi.name;
    # group = config.users.users.uwsgi.group;
    mode = "0444";
    sopsFile = ./secrets.yaml;
  };

  containers.searxng = {
    autoStart = true;

    bindMounts."/run/secrets/searxng" = {
      hostPath = config.sops.secrets.searxng.path;
    };

    # network
    privateNetwork = true;
    hostAddress = "10.10.2.1";
    localAddress = "10.10.2.2";
    hostAddress6 = "fc00::3";
    localAddress6 = "fc00::4";

    config = {...}: {
      services.searx = {
        enable = true;
        redisCreateLocally = true;
        runInUwsgi = true;
        settingsFile = "/run/secrets/searxng";
      };

      networking.firewall.allowedTCPPorts = [8080];
    };
  };
}
