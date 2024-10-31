{
  config,
  lib,
  pkgs,
  secretsPath,
  ...
}: let
  keycloakPkg =
    (pkgs.keycloak.overrideAttrs (_: rec {
      version = "25.0.0";
      src = pkgs.fetchzip {
        url = "https://github.com/keycloak/keycloak/releases/download/${version}/keycloak-${version}.zip";
        hash = "sha256-EsxUDYFZ0HKNjVvPylMLyg15IuAR9sbP0DRIQV3xMB0=";
      };
    }))
    .override
    {
      extraFeatures = ["persistent-user-sessions"];
    };
in {
  services.nginx.virtualHosts."auth.schwem.io" = let
    ip = "127.0.0.1";
    port = "8480";
  in {
    locations = {
      "/admin" = {
        proxyPass = "http://${ip}:${port}/admin";
      };
      "/js" = {
        proxyPass = "http://${ip}:${port}/js";
      };
      "/realms" = {
        proxyPass = "http://${ip}:${port}/realms";
      };
      "/resources" = {
        proxyPass = "http://${ip}:${port}/resources";
      };
      "/robots.txt" = {
        proxyPass = "http://${ip}:${port}/robots.txt";
      };
    };
  };

  services.keycloak = {
    enable = true;

    database = {
      passwordFile = config.sops.secrets.keycloak_db_password.path;
      type = "postgresql";
      useSSL = false;
    };

    package = lib.mkForce keycloakPkg;

    settings = {
      features = "persistent-user-sessions";
      hostname = "https://auth.schwem.io";
      hostname-admin = "https://auth.schwem.io";
      http-enabled = true;
      http-port = 8480;
      proxy-headers = "xforwarded";
    };
  };

  sops.secrets.keycloak_db_password = {
    sopsFile = "${secretsPath}/server/keycloak.yaml";
    mode = "0444";
  };
}
