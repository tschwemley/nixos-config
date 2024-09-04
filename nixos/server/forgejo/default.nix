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
      passwordFile = config.sops.secrets.forgejo_db_password.path;
    };

    lfs.enable = true;

    settings.server = {
      ROOT_URL = "https://git.schwem.io";
      HTTP_PORT = config.portMap.forgejo;
    };
  };

  sops.secrets.forgejo_db_password = {
    sopsFile = ./secrets.yaml;
  };
}
