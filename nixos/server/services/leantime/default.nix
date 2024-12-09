# Auto-generated using compose2nix v0.3.1.
{
  pkgs,
  lib,
  ...
}: {
  # Containers
  virtualisation.oci-containers.containers."leantime" = {
    image = "leantime/leantime:latest";
    environment = {
      "LEAN_APP_DIR" = "";
      "LEAN_APP_URL" = "";
      "LEAN_DB_BACKUP_PATH" = "backupdb/";
      "LEAN_DB_DATABASE" = "";
      "LEAN_DB_HOST" = "localhost";
      "LEAN_DB_PASSWORD" = "";
      "LEAN_DB_PORT" = "3306";
      "LEAN_DB_USER" = "";
      "LEAN_DEBUG" = "0";
      "LEAN_DEFAULT_THEME" = "default";
      "LEAN_DEFAULT_TIMEZONE" = "America/Los_Angeles";
      "LEAN_DISABLE_LOGIN_FORM" = "false";
      "LEAN_EMAIL_RETURN" = "";
      "LEAN_EMAIL_SMTP_AUTH" = "true";
      "LEAN_EMAIL_SMTP_AUTO_TLS" = "true";
      "LEAN_EMAIL_SMTP_HOSTS" = "";
      "LEAN_EMAIL_SMTP_PASSWORD" = "";
      "LEAN_EMAIL_SMTP_PORT" = "";
      "LEAN_EMAIL_SMTP_SECURE" = "";
      "LEAN_EMAIL_SMTP_SSLNOVERIFY" = "false";
      "LEAN_EMAIL_SMTP_USERNAME" = "";
      "LEAN_EMAIL_USE_SMTP" = "false";
      "LEAN_LANGUAGE" = "en-US";
      "LEAN_LDAP_DEFAULT_ROLE_KEY" = "20;";
      "LEAN_LDAP_DN" = "";
      "LEAN_LDAP_GROUP_ASSIGNMENT" = "{
                 \"5\": {
                   \"ltRole\":\"readonly\",
                   \"ldapRole\":\"readonly\"
                 },
                 \"10\": {
                   \"ltRole\":\"commenter\",
                    \"ldapRole\":\"commenter\"
                 },
                 \"20\": {
                   \"ltRole\":\"editor\",
                    \"ldapRole\":\"editor\"
                 },
                 \"30\": {
                   \"ltRole\":\"manager\",
                    \"ldapRole\":\"manager\"
                 },
                 \"40\": {
                   \"ltRole\":\"admin\",
                    \"ldapRole\":\"administrators\"
                 },
                 \"50\": {
                   \"ltRole\":\"owner\",
                   \"ldapRole\":\"administrators\"
                 }
  }";
      "LEAN_LDAP_HOST" = "";
      "LEAN_LDAP_KEYS" = "{
          \"username\":\"uid\",
          \"groups\":\"memberOf\",
          \"email\":\"mail\",
          \"firstname\":\"displayname\",
          \"lastname\":\"\",
          \"phone\":\"telephoneNumber\",
          \"jobTitle\":\"title\"
          \"jobLevel\":\"level\"
          \"department\":\"department\"
  
  }";
      "LEAN_LDAP_LDAP_DOMAIN" = "";
      "LEAN_LDAP_LDAP_TYPE" = "OL";
      "LEAN_LDAP_PORT" = "389";
      "LEAN_LDAP_URI" = "";
      "LEAN_LDAP_USE_LDAP" = "false";
      "LEAN_LOGO_PATH" = "/dist/images/logo.svg";
      "LEAN_LOG_PATH" = "";
      "LEAN_OIDC_CREATE_USER" = "false";
      "LEAN_OIDC_DEFAULT_ROLE" = "20";
      "LEAN_OIDC_ENABLE" = "false";
      "LEAN_PRIMARY_COLOR" = "#006d9f";
      "LEAN_PRINT_LOGO_URL" = "/dist/images/logo.png";
      "LEAN_RATELIMIT_API" = "10";
      "LEAN_RATELIMIT_AUTH" = "20";
      "LEAN_RATELIMIT_GENERAL" = "1000";
      "LEAN_REDIS_HOST" = "";
      "LEAN_REDIS_PASSWORD" = "";
      "LEAN_REDIS_PORT" = "6379";
      "LEAN_REDIS_SCHEME" = "";
      "LEAN_REDIS_URL" = "";
      "LEAN_S3_BUCKET" = "";
      "LEAN_S3_END_POINT" = "null";
      "LEAN_S3_FOLDER_NAME" = "";
      "LEAN_S3_KEY" = "";
      "LEAN_S3_REGION" = "";
      "LEAN_S3_SECRET" = "";
      "LEAN_S3_USE_PATH_STYLE_ENDPOINT" = "false";
      "LEAN_SECONDARY_COLOR" = "#00a886";
      "LEAN_SESSION_EXPIRATION" = "28800";
      "LEAN_SESSION_PASSWORD" = "3evBlq9zdUEuzKvVJHWWx3QzsQhturBApxwcws2m";
      "LEAN_SESSION_SECURE" = "false";
      "LEAN_SITENAME" = "Leantime";
      "LEAN_USER_FILE_PATH" = "userfiles/";
      "LEAN_USE_REDIS" = "false";
      "LEAN_USE_S3" = "false";
    };
    # volumes = [
    # "leantime_plugins:/var/www/html/app/Plugins:rw"
    # "leantime_public_userfiles:/var/www/html/public/userfiles:rw"
    # "leantime_userfiles:/var/www/html/userfiles:rw"
    # ];
    ports = [
      "80/tcp"
    ];
    dependsOn = [
      "mysql_leantime"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=leantime"
      "--network=leantime_leantime-net"
    ];
  };

  systemd = {
    services = {
      "podman-leantime".serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      "podman-leantime".after = [
        "podman-network-leantime_leantime-net.service"
        # "podman-volume-leantime_plugins.service"
        # "podman-volume-leantime_public_userfiles.service"
        # "podman-volume-leantime_userfiles.service"
      ];
      "podman-leantime".requires = [
        "podman-network-leantime_leantime-net.service"
        # "podman-volume-leantime_plugins.service"
        # "podman-volume-leantime_public_userfiles.service"
        # "podman-volume-leantime_userfiles.service"
      ];
      "podman-leantime".partOf = [
        "podman-compose-leantime-root.target"
      ];
      "podman-leantime".wantedBy = [
        "podman-compose-leantime-root.target"
      ];
      "podman-mysql_leantime" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-leantime_leantime-net.service"
          # "podman-volume-leantime_db_data.service"
        ];
        requires = [
          "podman-network-leantime_leantime-net.service"
          # "podman-volume-leantime_db_data.service"
        ];
        partOf = [
          "podman-compose-leantime-root.target"
        ];
        wantedBy = [
          "podman-compose-leantime-root.target"
        ];
      };

      # Networks
      "podman-network-leantime_leantime-net" = {
        path = [pkgs.podman];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "podman network rm -f leantime_leantime-net";
        };
        script = ''
          podman network inspect leantime_leantime-net || podman network create leantime_leantime-net
        '';
        partOf = ["podman-compose-leantime-root.target"];
        wantedBy = ["podman-compose-leantime-root.target"];
      };

      # Volumes
      "podman-volume-leantime_db_data" = {
        path = [pkgs.podman];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          podman volume inspect leantime_db_data || podman volume create leantime_db_data
        '';
        partOf = ["podman-compose-leantime-root.target"];
        wantedBy = ["podman-compose-leantime-root.target"];
      };
      # "podman-volume-leantime_plugins" = {
      #   path = [pkgs.podman];
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = true;
      #   };
      #   script = ''
      #     podman volume inspect leantime_plugins || podman volume create leantime_plugins
      #   '';
      #   partOf = ["podman-compose-leantime-root.target"];
      #   wantedBy = ["podman-compose-leantime-root.target"];
      # };
      # "podman-volume-leantime_public_userfiles" = {
      #   path = [pkgs.podman];
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = true;
      #   };
      #   script = ''
      #     podman volume inspect leantime_public_userfiles || podman volume create leantime_public_userfiles
      #   '';
      #   partOf = ["podman-compose-leantime-root.target"];
      #   wantedBy = ["podman-compose-leantime-root.target"];
      # };
      # "podman-volume-leantime_userfiles" = {
      #   path = [pkgs.podman];
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = true;
      #   };
      #   script = ''
      #     podman volume inspect leantime_userfiles || podman volume create leantime_userfiles
      #   '';
      #   partOf = ["podman-compose-leantime-root.target"];
      #   wantedBy = ["podman-compose-leantime-root.target"];
      # };
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    targets."podman-compose-leantime-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  virtualisation.oci-containers.containers."mysql_leantime" = {
    image = "mysql:8.4";
    environment = {
      "LEAN_APP_DIR" = "";
      "LEAN_APP_URL" = "";
      "LEAN_DB_BACKUP_PATH" = "backupdb/";
      "LEAN_DB_DATABASE" = "";
      "LEAN_DB_HOST" = "localhost";
      "LEAN_DB_PASSWORD" = "";
      "LEAN_DB_PORT" = "3306";
      "LEAN_DB_USER" = "";
      "LEAN_DEBUG" = "0";
      "LEAN_DEFAULT_THEME" = "default";
      "LEAN_DEFAULT_TIMEZONE" = "America/Los_Angeles";
      "LEAN_DISABLE_LOGIN_FORM" = "false";
      "LEAN_EMAIL_RETURN" = "";
      "LEAN_EMAIL_SMTP_AUTH" = "true";
      "LEAN_EMAIL_SMTP_AUTO_TLS" = "true";
      "LEAN_EMAIL_SMTP_HOSTS" = "";
      "LEAN_EMAIL_SMTP_PASSWORD" = "";
      "LEAN_EMAIL_SMTP_PORT" = "";
      "LEAN_EMAIL_SMTP_SECURE" = "";
      "LEAN_EMAIL_SMTP_SSLNOVERIFY" = "false";
      "LEAN_EMAIL_SMTP_USERNAME" = "";
      "LEAN_EMAIL_USE_SMTP" = "false";
      "LEAN_LANGUAGE" = "en-US";
      "LEAN_LDAP_DEFAULT_ROLE_KEY" = "20;";
      "LEAN_LDAP_DN" = "";
      "LEAN_LDAP_GROUP_ASSIGNMENT" = "{
                 \"5\": {
                   \"ltRole\":\"readonly\",
                   \"ldapRole\":\"readonly\"
                 },
                 \"10\": {
                   \"ltRole\":\"commenter\",
                    \"ldapRole\":\"commenter\"
                 },
                 \"20\": {
                   \"ltRole\":\"editor\",
                    \"ldapRole\":\"editor\"
                 },
                 \"30\": {
                   \"ltRole\":\"manager\",
                    \"ldapRole\":\"manager\"
                 },
                 \"40\": {
                   \"ltRole\":\"admin\",
                    \"ldapRole\":\"administrators\"
                 },
                 \"50\": {
                   \"ltRole\":\"owner\",
                   \"ldapRole\":\"administrators\"
                 }
  }";
      "LEAN_LDAP_HOST" = "";
      "LEAN_LDAP_KEYS" = "{
          \"username\":\"uid\",
          \"groups\":\"memberOf\",
          \"email\":\"mail\",
          \"firstname\":\"displayname\",
          \"lastname\":\"\",
          \"phone\":\"telephoneNumber\",
          \"jobTitle\":\"title\"
          \"jobLevel\":\"level\"
          \"department\":\"department\"
  
  }";
      "LEAN_LDAP_LDAP_DOMAIN" = "";
      "LEAN_LDAP_LDAP_TYPE" = "OL";
      "LEAN_LDAP_PORT" = "389";
      "LEAN_LDAP_URI" = "";
      "LEAN_LDAP_USE_LDAP" = "false";
      "LEAN_LOGO_PATH" = "/dist/images/logo.svg";
      "LEAN_LOG_PATH" = "";
      "LEAN_OIDC_CREATE_USER" = "false";
      "LEAN_OIDC_DEFAULT_ROLE" = "20";
      "LEAN_OIDC_ENABLE" = "false";
      "LEAN_PRIMARY_COLOR" = "#006d9f";
      "LEAN_PRINT_LOGO_URL" = "/dist/images/logo.png";
      "LEAN_RATELIMIT_API" = "10";
      "LEAN_RATELIMIT_AUTH" = "20";
      "LEAN_RATELIMIT_GENERAL" = "1000";
      "LEAN_REDIS_HOST" = "";
      "LEAN_REDIS_PASSWORD" = "";
      "LEAN_REDIS_PORT" = "6379";
      "LEAN_REDIS_SCHEME" = "";
      "LEAN_REDIS_URL" = "";
      "LEAN_S3_BUCKET" = "";
      "LEAN_S3_END_POINT" = "null";
      "LEAN_S3_FOLDER_NAME" = "";
      "LEAN_S3_KEY" = "";
      "LEAN_S3_REGION" = "";
      "LEAN_S3_SECRET" = "";
      "LEAN_S3_USE_PATH_STYLE_ENDPOINT" = "false";
      "LEAN_SECONDARY_COLOR" = "#00a886";
      "LEAN_SESSION_EXPIRATION" = "28800";
      "LEAN_SESSION_PASSWORD" = "3evBlq9zdUEuzKvVJHWWx3QzsQhturBApxwcws2m";
      "LEAN_SESSION_SECURE" = "false";
      "LEAN_SITENAME" = "Leantime";
      "LEAN_USER_FILE_PATH" = "userfiles/";
      "LEAN_USE_REDIS" = "false";
      "LEAN_USE_S3" = "false";
    };
    # volumes = [
    #   "leantime_db_data:/var/lib/mysql:rw"
    # ];
    cmd = ["--character-set-server=UTF8MB4" "--collation-server=UTF8MB4_unicode_ci"];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=leantime_db"
      "--network=leantime_leantime-net"
    ];
  };
}
