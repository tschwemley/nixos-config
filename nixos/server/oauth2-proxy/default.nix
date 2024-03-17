{config, ...}: {
  imports = [./env.nix];

  services.oauth2_proxy = {
    enable = true;
    clientID = "oauth2-proxy";
    keyFile = config.sops.templates.oauth2_proxy_env.path;
    # loginURL = "https://schwem.io/oauth/authorize";
    nginx = {
      proxy = "https://schwem.io/oauth";
      # these are the virtual hosts protected by oauth2-proxy
      virtualHosts = [];
    };
    proxy = {
      provider = "keycloak-oidc";
    };
    reverseProxy = true;
  };
}
