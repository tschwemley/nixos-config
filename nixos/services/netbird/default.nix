{config, ...}: {
  imports = [
    ./management.nix
  ];

  sops.secrets.netbirdBackendSecret = {
    sopsFile = ./secrets.yaml;
  };

  virtualisation.oci-containers.containers = {
    netbird-dashboard = {
      image = "netbirdio/dashboard:main";
      environment = {
        NETBIRD_MGMT_API_ENDPOINT = "https://netbird.schwem.io:33073";
        NETBIRD_MGMT_GRPC_API_ENDPOINT = "https://netbird.schwem.io:33073";
        # OIDC
        AUTH_AUDIENCE = "netbird-client";
        AUTH_CLIENT_ID = "netbird-client";
        AUTH_CLIENT_SECRET = "";
        AUTH_AUTHORITY = "https://auth.schwem.io/realms/netbird";
        USE_AUTH0 = "false";
        AUTH_SUPPORTED_SCOPES = "openid profile email offline_access api";
        AUTH_REDIRECT_URI = "";
        AUTH_SILENT_REDIRECT_URI = "";
        NETBIRD_TOKEN_SOURCE = "accessToken";
        # # SSL
        # NGINX_SSL_PORT = "443";
        # # Letsencrypt
        # LETSENCRYPT_DOMAIN = "";
        # LETSENCRYPT_EMAIL = "";
      };
      # volumes:
      #   - netbird-letsencrypt:/etc/letsencrypt/
      ports = [
        "127.0.0.1:8180:80"
      ];
      command = ["--letsencrypt-domain=" "--log-file" "console"];
    };

    netbird-signal = {
      image = "netbirdio/signal:latest";
      volumes = [
        "/var/lib/netbird:/var/lib/netbird"
      ];
      ports = [
        "127.0.0.1:10000:80"
      ];
    };

    netbird-management = {
      image = "netbirdio/management:latest";
      cmd = [
        "--port"
        "443"
        "--log-file"
        "console"
        "--disable-anonymous-metrics=true"
        "--single-account-mode-domain=netbird.schwem.io"
        "--dns-domain=netbird.selfhosted"
      ];
      ports = [
        "127.0.0.1:33073:443"
      ];
      volumes = [
        "/var/lib/netbird:/var/lib/netbird"
        "${config.sops.templates.netbirdMgmtConfig.path}:/etc/netbird/management.json"
      ];
      dependsOn = "netbird-dashboard";
    };
  };
}
