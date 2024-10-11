{ config, pkgs, ... }:
let
  keycloakPkg = pkgs.keycloak.overrideAttrs (_: rec {
    version = "24.0.5";
    src = pkgs.fetchzip {
      url = "https://github.com/keycloak/keycloak/releases/download/${version}/keycloak-${version}.zip";
      hash = "sha256-lf1miVEGQvPbmlOZMCXUyX/pKE+JoJFawhjVEPJDJ6s=";
    };
  });
in
{
  environment.systemPackages = [ keycloakPkg ];
  services.nginx.virtualHosts."auth.schwem.io" =
    let
      ip = "127.0.0.1";
      port = "8480";
    in
    {
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

    package = keycloakPkg;

    settings = {
      hostname = "auth.schwem.io";
      hostname-admin-url = "https://auth.schwem.io"; # this is important to prevent endless loading admin page
      http-port = 8480;
      proxy-headers = "forwarded"; # forwarded || xforwarded
      transaction-xa-enable = false;
    };

    # initialAdminPassword = "<set_to_rand_string>"; # change on first login
  };

  sops.secrets.keycloak_db_password = {
    sopsFile = ./secrets.yaml;
    mode = "0444";
  };
}
