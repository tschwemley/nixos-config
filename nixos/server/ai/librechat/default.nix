{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  listenAddress = "127.0.0.1";
  librechatPort = "3080";

  # TODO: move the mongo setup script out (probably create a new mongo service option)
  mongo-setup-script = pkgs.writeShellScript "librechat-mongo-setup" ''
    #!${pkgs.runtimeShell}
    set -euo pipefail
    # this command will fail if the user already exists, which is fine.
    # we could make this more robust, but for now this is sufficient.
    ${lib.getExe pkgs.mongosh} admin \
      --username root \
      --password "$(cat ${config.sops.secrets.mongoRootPassword.path})" \
      --eval "db.getSiblingDB('LibreChat').createUser({ \
        user: 'librechat', \
        pwd: '$(cat ${config.sops.secrets.librechatMongoPassword.path})', \
        roles: [ { role: 'readWrite', db: 'LibreChat' } ] \
      })" || true
  '';
in {
  # imports = [./module.nix];
  imports = [self.inputs.librechat.nixosModules.librechat];

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
        OPENID_CLIENT_SECRET = config.sops.secrets.librechatOpenIDClientSecret.path;
        OPENID_SESSION_SECRET = config.sops.secrets.librechatOpenIDSessionSecret.path;
        OPENROUTER_KEY = config.sops.secrets.librechatOpenRouterKey.path;
      };

      env = {
        # Server settings
        HOST = listenAddress;
        DOMAIN_CLIENT = "https://ai.schwem.io";
        DOMAIN_SERVER = "https://ai.schwem.io";

        # General settings
        ALLOW_REGISTRATION = "false";
        ALLOW_SOCIAL_LOGIN = "true";

        NO_INDEX = "true";

        MEILI_NO_ANALYTICS = "true";

        # OpenID configuration
        OPENID_CLIENT_ID = "librechat";
        OPENID_CALLBACK_URL = "/oauth/openid/callback";
        OPENID_ISSUER = "https://auth.schwem.io/realms/schwem-io";
        OPENID_REQUIRED_ROLE = "user";
        OPENID_REQUIRED_ROLE_PARAMETER_PATH = "resource_access.librechat.roles";
        # OPENID_REQUIRED_ROLE_TOKEN_KIND = "(access|id)";
        OPENID_REQUIRED_ROLE_TOKEN_KIND = "id";
        OPENID_SCOPE = "openid profile email";
        OPENID_USE_END_SESSION_ENDPOINT = "true";
      };

      # NOTE: settings is free-form nix attribute set that will be converted to librechat.yaml
      settings = {
        version = "1.2.5";
        cache = true;
        endpoints.custom = [
          {
            name = "OpenRouter";
            apiKey = "\${OPENROUTER_KEY}";
            baseURL = "https://openrouter.ai/api/v1";
            models = {
              default = ["google/gemini-2.5-pro-preview"];
              fetch = true;
            };
            titleConvo = true;
            titleModel = "google/gemini-2.5-flash-preview-05-20";
            summarize = false;
            summaryModel = "google/gemini-2.5-flash-preview-05-20";
            forcePrompt = false;
            modelDisplayLabel = "OpenRouter";
          }
        ];
      };

      ragApi = let
        port = lib.toInt config.variables.ports.librechat-rag;
      in {
        inherit port;

        enable = true;

        credentials = {
          DB_HOST = config.sops.secrets.ragDBHost.path;
          DB_PORT = config.sops.secrets.ragDBPort.path;
          POSTGRES_PASSWORD = config.sops.secrets.ragPostgresPassword.path;
        };

        env = {
          EMBEDDING_MODEL = "huggingface";
          RAG_HOST = listenAddress;
          RAG_PORT = port;
          RAG_UPLOAD_DIR = "${config.services.librechat.workDir}/uploads";
          POSTGRES_DB = "librechat";
          POSTGRES_USER = "librechat";
          VECTOR_DB_TYPE = "pgvector";
        };
      };
    };

    mongodb = {
      enable = true;
      enableAuth = true;
      initialRootPasswordFile = config.sops.secrets.mongoRootPassword.path;
      package = pkgs.mongodb-ce;
    };

    nginx.virtualHosts."ai.schwem.io".locations = {
      "/" = {
        proxyPass = "http://${listenAddress}:${librechatPort}";
        extraConfig = ''
          proxy_cache_bypass $http_upgrade;
        '';
      };
    };
  };

  systemd.services.librechat-mongodb-setup = {
    description = "Initial MongoDB setup for LibreChat";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = "${mongo-setup-script}";
    };
    after = ["mongodb.service"];
    requires = ["mongodb.service"];
    wantedBy = ["multi-user.target"];
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
    librechatMongoPassword = getSecret "mongo_pw";
    librechatOpenIDClientSecret = getSecret "openid_client_secret";
    librechatOpenIDSessionSecret = getSecret "openid_session_secret";
    librechatOpenRouterKey = getSecret "openrouter_key";
    mongoRootPassword = getSecret "mongo_root_pw";

    # rag scecrets
    librechatRagDBHost = getSecret "rag_db_host";
    librechatRagDBPort = getSecret "rag_db_port";
    librechatRagPostgresPassword = getSecret "rag_postgres_password";
  };
}
