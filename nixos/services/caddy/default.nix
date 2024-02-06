{
  networking.firewall.allowedTCPPorts = [80 443];

  services.caddy = {
    enable = true;

    acmeCA = "https://acme-staging-v02.api.letsencrypt.org/directory";
    email = "automation@schwem.io";
  };

  # TODO: decide if worth keeping or not
  sops.secrets.caddy_email = {
    sopsFile = ./secrets.yaml;
  };
}
