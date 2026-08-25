{ config, lib, ... }: {
  services.firefox-syncserver = {
    enable = true;
    secrets = config.sops.secrets.firefox-sync.path;

    database = {
      createLocally = true;
      type = "postgresql";
    };

    singleNode = {
      enable = true;
      enableNginx = true;

      capacity = 2;
      hostname = "127.0.0.1";
      url = "https://ffsync.schwem.io";
    };
  };

  sops.secrets.firefox-sync = {
    group = config.systemd.services.firefox-syncserver.serviceConfig.Group;
    owner = config.systemd.services.firefox-syncserver.serviceConfig.User;

    format = "dotenv";
    key = "";
    mode = "400";
    sopsFile = lib.secret "server" "firefox-sync.env";
  };
}
