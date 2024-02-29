{config, ...}: {
  imports = [./virtualhost.nix];
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
    hostAddress = "10.1.1.1";
    localAddress = "10.1.1.2";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    config = {lib, ...}: {
      services.keycloak = {
        enable = true;
        database.passwordFile = "/run/secrets/db_password";
        settings = {
          hostname = "auth.schwem.io";
          # hostname-strict-backchannel = true;
          proxy = "edge";
        };
        # initialAdminPassword = "e6Wcm0RrtegMEHl"; # change on first login
        # sslCertificate = "/run/keys/ssl_cert";
        # sslCertificateKey = "/run/keys/ssl_key";
      };

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [80];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };
}
