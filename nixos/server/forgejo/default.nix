{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      # convenience wrapper for using the cli without having switch user or define config file location
      (pkgs.writeShellScriptBin "forgejo" ''
        sudo -u forgejo ${pkgs.forgejo-lts}/bin/gitea -c ${config.services.forgejo.customDir}/conf/app.ini "$@"
      '')
    ];
  };

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
      database = {
        AUTO_MIGRATION = false;
      };

      oauth = {
        ENABLED = true;
      };

      openid = {
        ENABLE_OPENID_SIGNIN = true;
      };

      session = {
        COOKIE_SECURE = true;
      };

      server = {
        ROOT_URL = "https://git.schwem.io";
        HTTP_PORT = lib.strings.toInt config.portMap.forgejo;
      };

      service = {
        DISABLE_REGISTRATION = true;
        ENABLE_BASIC_AUTHENTICATION = false;
      };
    };
  };

  sops.secrets =
    let
      sopsConfig = {
        sopsFile = ./secrets.yaml;
      };
    in
    {
      forgejo_db_password = sopsConfig;
      forgejo_smtp_server = sopsConfig;
      forgejo_smtp_token = sopsConfig;
    };
}
