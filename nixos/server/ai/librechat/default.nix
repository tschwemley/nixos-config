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
        CREDS_KEY = config.sops.secrets.librechatCredsKey.path;
        CREDS_IV = config.sops.secrets.librechatCredsIV.path;
        JWT_SECRET = config.sops.secrets.librechatJwtSecret.path;
        JWT_REFRESH_SECRET = config.sops.secrets.librechatJwtRefreshSecret.path;
        MEILI_MASTER_KEY = config.sops.secrets.librechatMeiliMasterKey.path;
        MONGO_URI = config.sops.secrets.librechatMongoUri.path;
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
      enableAuth = true;
      initialRootPasswordFile = config.sops.secrets.mongoRootPassword.path;
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
    librechatCredsKey = getSecret "creds_key";
    librechatCredsIV = getSecret "creds_iv";
    librechatJwtSecret = getSecret "jwt_secret";
    librechatJwtRefreshSecret = getSecret "jwt_refresh_secret";
    librechatMeiliMasterKey = getSecret "meili_master_key";
    librechatMongoUri = getSecret "mongo_uri";
    mongoRootPassword = getSecret "mongo_root_pw";
    librechatMongoPassword = getSecret "mongo_pw";
  };
}
