{config, ...}: {
  imports = [./virtualhost.nix];

  networking.firewall.trustedInterfaces = ["ve-keycloak"];

  sops.secrets.db_password = {
    sopsFile = ./secrets.yaml;
    mode = "0444";
  };

  containers.keycloak = {
    autoStart = true;

    bindMounts."/run/secrets/db_password" = {
      hostPath = config.sops.secrets.db_password.path;
    };

    # network
    privateNetwork = true;
    hostAddress = "10.10.1.1";
    localAddress = "10.10.1.2";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    config = {lib, ...}: {
      imports = [../.];

      networking.firewall.allowedTCPPorts = [80];

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

        settings = {
          hostname = "auth.schwem.io";
          # this is important to prevent endless loading admin page
          hostname-admin-url = "https://auth.schwem.io";
          proxy = "edge";
          transaction-xa-enable = false;
        };

        # initialAdminPassword = "<set_to_rand_string>"; # change on first login
      };
    };
  };
}
