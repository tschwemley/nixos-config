{
  self,
  config,
  pkgs,
  ...
}: {
  imports = [./module.nix];

  services = {
    librechat = {
      enable = true;

      credentials = let
        secretPath = config.sops.secrets.librechat.path;
      in {
        CREDS_KEY = secretPath;
        CREDS_IV = secretPath;
        JWT_KEY = secretPath;
        JWT_REFRESH_KEY = secretPath;
        MEILI_MASTER_KEY = secretPath;
        MONGO_URI = secretPath;
      };

      env = {
        ALLOW_REGISTRATION = "false";
        HOST = "127.0.0.1";
      };

      # NOTE: settings is free-form nix attribute set that will be converted to librechat.yaml
      settings = {};
    };

    mongodb = {
      enable = true;
      initialRootPasswordFile = config.sops.secrets.librechat-mongo.path;
      package = pkgs.mongodb-ce;
    };
  };

  sops.secrets = let
    owner = config.services.librechat.user;
    group = config.services.librechat.user;
    mode = "0400";
  in {
    librechat = {
      inherit group owner mode;

      format = "dotenv";
      sopsFile = self.lib.secret "server" "librechat-creds.env";
    };

    librechat-mongo = {
      inherit group owner mode;

      key = "mongo_pw";
      sopsFile = self.lib.secret "server" "librechat.yaml";
    };
  };
}
