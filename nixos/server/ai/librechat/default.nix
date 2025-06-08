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

      credentials = {
        CREDS_KEY = config.sops.secrets.librechat-creds-key.path;
        CREDS_IV = config.sops.secrets.librechat-creds-iv.path;
        JWT_SECRET = config.sops.secrets.librechat-jwt-secret.path;
        JWT_REFRESH_SECRET = config.sops.secrets.librechat-jwt-refresh-secret.path;
        MEILI_MASTER_KEY = config.sops.secrets.librechat-meili-master-key.path;
        MONGO_URI = config.sops.secrets.librechat-mongo-uri.path;
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
      initialRootPasswordFile = config.sops.secrets.librechat-mongo-pw.path;
      package = pkgs.mongodb-ce;
    };
  };

  sops.secrets = let
    group = config.services.librechat.user;
    owner = config.services.librechat.user;
    mode = "0400";
    sopsFile = self.lib.secret "server" "librechat.yaml";

    getSecret = key: {inherit group owner mode sopsFile key;};
  in {
    librechat-creds-key = getSecret "creds_key";
    librechat-creds-iv = getSecret "creds_iv";
    librechat-jwt-secret = getSecret "jwt_secret";
    librechat-jwt-refresh-secret = getSecret "jwt_refresh_secret";
    librechat-meili-master-key = getSecret "meili_master_key";
    librechat-mongo-uri = getSecret "mongo_uri";
    librechat-mongo-pw = getSecret "mongo_pw";
  };
}
