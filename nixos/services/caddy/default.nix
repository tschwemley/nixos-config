{config, ...}: {
  config.sops.secrets.caddy_email = {
    sopsFile = ./secrets.yaml;
  };

  networking.allowedTCPPorts = [80 443];

  services.caddy = {
    enable = true;

    acmeCA = "https://acme-staging-v02.api.letsencrypt.org/directory";
    email = builtins.readFile config.sops.caddy_email.path;
  };
}
