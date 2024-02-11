{
  networking.firewall.allowedTCPPorts = [80 443];

  # TODO: move this to it's own file if shit gets complex enough
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "automation@schwem.io";
  # uncomment when testing
  # security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
}
