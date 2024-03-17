{config, ...}: {
  imports = [./env.nix];

  services.oauth2_proxy = {
    enable = true;
    clientID = "oauth2-proxy";
    email.domains = "*";
    keyFile = config.sops.templates."oauth2_proxy_env".path;
    # loginURL = "https://schwem.io/oauth/authorize";
    nginx = {
      proxy = "https://auth.schwem.io/oauth";
      # these are the virtual hosts protected by oauth2-proxy
      virtualHosts = [];
    };
    provider = "keycloak-oidc";
    reverseProxy = true;
  };
}
