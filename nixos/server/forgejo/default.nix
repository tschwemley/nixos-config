{ config, lib, ... }:
{
  services.nginx = {
    virtualHosts."git.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${config.portMap.forgejo}";
        extraConfig = "client_max_body_size 512M;";
      };
    };
  };

  services.forgejo = {
    enable = true;

    database = {
      passwordFile = config.sops.secrets.forgejo_db_password.path;
    };

    lfs.enable = true;

    settings = {
      server = {
        ROOT_URL = "https://git.schwem.io";
        HTTP_PORT = lib.strings.toInt config.portMap.forgejo;
      };

      service = {
        DISABLE_REGISTRATION = true;
      };
    };
  };

  sops.secrets.forgejo_db_password = {
    sopsFile = ./secrets.yaml;
  };
}
