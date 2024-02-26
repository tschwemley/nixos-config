{config, ...}: {
  services.keycloak = {
    enable = true;
    database.passwordFile = config.sops.secrets.db_password.path;
    settings = {
      hostname = "auth.schwem.io";
      # hostname-strict-backchannel = true;
      proxy = "edge";
    };
    # initialAdminPassword = "e6Wcm0RrtegMEHl"; # change on first login
    # sslCertificate = "/run/keys/ssl_cert";
    # sslCertificateKey = "/run/keys/ssl_key";
  };

  networking.firewall.allowedTCPPorts = [80];

  sops.secrets.db_password = {
    sopsFile = ./secrets.yaml;
    mode = "0444";
  };
}
