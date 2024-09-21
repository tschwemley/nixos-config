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
  services = {
    postgresql = {
      ensureDatabases = [ "keycloak" ];

      ensureUsers = [
        {
          name = "keycloak";
          ensureDBOwnership = true;
        }
      ];
    };

    # nginx.virtualHosts."auth.schwem.io" =
    #   let
    #     ip = "127.0.0.1";
    #     port = 8480;
    #   in
    #   {
    #     locations = {
    #       "/admin" = {
    #         proxyPass = "http://${ip}:${port}/admin";
    #       };
    #       "/js" = {
    #         proxyPass = "http://${ip}:${port}/js";
    #       };
    #       "/realms" = {
    #         proxyPass = "http://${ip}:${port}/realms";
    #       };
    #       "/resources" = {
    #         proxyPass = "http://${ip}:${port}/resources";
    #       };
    #       "/robots.txt" = {
    #         proxyPass = "http://${ip}:${port}/robots.txt";
    #       };
    #     };
    #   };

    keycloak = {
      enable = true;

      database = {
        passwordFile = config.sops.secrets.keycloak_db_password.path;
        type = "postgresql";
        useSSL = false;
      };

      package = keycloakPkg;

      settings = {
        # hostname = "auth-test.schwem.io";
        hostname = "jolteon"; # TODO: only set to jolteon for testing
        # this is important to prevent endless loading admin page
        # hostname-admin-url = "https://auth-test.schwem.io";
        http-port = 8480;
        proxy = "edge";
        transaction-xa-enable = false;
      };

      # initialAdminPassword = "<set_to_rand_string>"; # change on first login
    };
  };

  sops.secrets.keycloak_db_password = {
    sopsFile = ./secrets.yaml;

    owner = "keycloak";
    group = "keycloak";
    # mode = "0444";
  };
}
