{pkgs, ...}: let
    keycloakPkg = pkgs.keycloak.overrideAttrs (_: rec {
      version = "24.0.5";
      src = pkgs.fetchzip {
        url = "https://github.com/keycloak/keycloak/releases/download/${version}/keycloak-${version}.zip";
        hash = "sha256-lf1miVEGQvPbmlOZMCXUyX/pKE+JoJFawhjVEPJDJ6s=";
      };
    });
in {
  services.keycloak = {
    enable = true;

    database = {
      host = "10.10.1.1";
      passwordFile = "/run/secrets/db_password";
      port = 5432;
      name = "keycloak";
      type = "postgresql";
      username = "keycloak";
      useSSL = false;
    };

    package = keycloakPkg;

    settings = {
      hostname = "auth.schwem.io";
      # this is important to prevent endless loading admin page
      hostname-admin-url = "https://auth.schwem.io";
      proxy = "edge";
      transaction-xa-enable = false;
    };

    # initialAdminPassword = "<set_to_rand_string>"; # change on first login
  };
}
