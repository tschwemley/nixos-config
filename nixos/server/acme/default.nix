{config, ...}: {
  security.acme = {
    acceptTerms = true;
    certs = {
      "schwem.io" = {};
      "schwem.io-wildcard" = {domain = "*.schwem.io";};
    };
    defaults = {
      credentialFiles = {
        CF_DNS_API_TOKEN_FILE = config.sops.secrets.cloudflareApiZoneKey.path;
      };
      dnsProvider = "cloudflare";
      email = "automation@schwem.io";
      # TODO: sops command postRun
      # postRun = ''
      #   ${pkgs.sops}/bin/sops --config ${../../../.sops.yaml}
      # '';
      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
  };

  sops.secrets.cloudflareApiZoneKey = {
    group = config.config.users.acme.group;
    owner = config.config.users.acme.name;
    sopsFile = ./secrets.yaml;
  };
}
