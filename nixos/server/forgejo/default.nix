{ config, ... }:
{
  services.nginx = {
    virtualHosts."git.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${config.portMap.forgejo}";
      };
    };
  };

  services.forgejo = {
    enable = true;

    database = {
      createDatabase = false;
      host = "db.schwem.io";
      name = "forgejo";
      type = "postgresql";
      passwordFile = config.sops.secrets.forgejo_db_password.path;
    };

    lfs.enable = true;

    settings = {
      DOMAIN = "git.schwem.io";
      PORT = config.portMap.forgejo;
    };
  };

  sops.secrets.forgejo_db_password = {
    sopsFile = ./secrets.yaml;
  };
}
