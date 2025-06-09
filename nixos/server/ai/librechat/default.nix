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

      initialScript = pkgs.writeTextFile {
        name = "mongodb-librechat-sops-init.js";

        # This JavaScript is executed by `mongosh`, which has a Node.js backend.
        # Therefore, we can use Node.js filesystem APIs like `fs.readFileSync`.
        text = let
          dbUser = "librechat";
          dbName = "LibreChat";
        in
          # javascript
          ''
            // Nix injects the *path* to the secret file here. This path is known at build time.
            const passwordFile = "${config.sops.secrets.librechatMongoPassword.path}";

            // The script reads the *content* of the secret file at RUNTIME.
            // `fs.readFileSync` reads the file, 'utf8' decodes it, and `.trim()`
            // removes any trailing whitespace or newlines.
            const password = fs.readFileSync(passwordFile, 'utf8').trim();

            // Get database and user info from Nix variables
            const dbName = '${dbName}';
            const user = '${dbUser}';

            // Switch to the correct database
            const libreChatDb = db.getSiblingDB(dbName);

            // Create the user with the password read from the sops secret file
            libreChatDb.createUser({
              user: user,
              pwd: password,
              roles: [
                { role: "readWrite", db: dbName }
              ]
            });
          '';
      };
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
