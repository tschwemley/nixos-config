{
  self,
  config,
  pkgs,
  ...
}:
{
  services = {
    postgresql = {
      enable = true;
      enableTCPIP = true;
      extensions = ps: with ps; [ pgvector ];

      authentication = ''
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        # Allow the system user 'postgres' to connect locally without a password
        local   all             postgres                                peer

        # Require a password for all other local connections
        local   all             all                                     scram-sha-256

        # Remote rules
        host    keycloak        keycloak        127.0.0.1/32            scram-sha-256
        host    all             all             100.64.0.0/10           scram-sha-256
      '';

      identMap = ''
        # mapName systemUser  DBUser
        user_map  root        postgres
        user_map  postgres    postgres

        # Let other names login as themselves
        user_map  /^(.*)$     \1
      '';

      initialScript =
        pkgs.writeText "postgresql-init-script"
          #sh
          ''
              # Read the password from the sops-nix secret file
              LIBRECHAT_PASSWORD=$(cat ${config.sops.secrets.librechatRagPostgresPassword.path})

              # Use psql's variable substitution (-v) to safely pass the password.
              # The :password syntax inside the SQL block is replaced by the variable.
              psql -v password="'$LIBRECHAT_PASSWORD'" <<EOSQL
                CREATE ROLE librechat WITH LOGIN PASSWORD :password;
                CREATE DATABASE librechat OWNER librechat;
            EOSQL

            INVIDIOUS_PASSWORD=$(cat ${config.sops.secrets.invidiousPostgresPassword.path})
              psql -v password="'$LIBRECHAT_PASSWORD'" <<EOSQL
                CREATE ROLE invidious WITH LOGIN PASSWORD :password;
                CREATE DATABASE invidious OWNER invidious;
            EOSQL
          '';
    };

    prometheus.exporters.postgres = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 9187;
    };
  };

  sops.secrets = {
    librechatRagPostgresPassword = {
      group = "postgres";
      key = "rag_postgres_password";
      mode = "0400";
      owner = "postgres";
      sopsFile = self.lib.secret "server" "librechat.yaml";
    };
  };
}
