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

  networking.firewall.allowedTCPPorts = [ 2222 ];

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

      repository = {
        ENABLE_PUSH_CREATE_USER = true;
      };

      session = {
        COOKIE_SECURE = true;
      };

      server = {
        LANDING_PAGE = "explore";
        HTTP_PORT = lib.strings.toInt config.portMap.forgejo;
        ROOT_URL = "https://git.schwem.io";
        SSH_DOMAIN = "git.schwem.io";
        SSH_PORT = 2222;
        START_SSH_SERVER = true;
      };

      service = {
        DISABLE_REGISTRATION = true;
        ENABLE_BASIC_AUTHENTICATION = false;
        SHOW_REGISTRATION_BUTTON = false;
      };

      ui = {
        DEFAULT_THEME = "forgejo-dark";
        SHOW_USER_EMAIL = false;
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
