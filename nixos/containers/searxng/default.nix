{config, ...}: {
  imports = [
    ./settings.nix
    ./virtualhost.nix
  ];

  sops.secrets.searxng = {
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

    config = {lib, ...}: {
      services.searx = {
        enable = true;
        redisCreateLocally = true;
        runInUwsgi = true;
        settingsFile = config.sops.templates."searxng_settings.yaml".path;
      };

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [8080];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };
}
