{config, ...}: {
  imports = [
    ./settings.nix
    ./virtualhost.nix
  ];

  containers.searxng = {
    autoStart = true;

    bindMounts."/run/secrets/searxng_settings.yaml" = {
      hostPath = config.sops.templates."searxng_settings.yaml".path;
    };

    # network
    privateNetwork = true;
    hostAddress = "10.10.2.1";
    localAddress = "10.10.2.2";
    hostAddress6 = "fc00::3";
    localAddress6 = "fc00::4";

    config = {lib, ...}: {
      imports = [../.];

      services.searx = {
        enable = true;
        redisCreateLocally = true;
        runInUwsgi = true;
        settingsFile = "/run/secrets/searxng_settings.yaml";
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [8080];
      };
    };
  };
}
