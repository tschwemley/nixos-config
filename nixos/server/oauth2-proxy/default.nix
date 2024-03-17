{config, ...}: {
  imports = [
    ./configuration.nix
    ./virtualhost.nix
  ];

  services.oauth2_proxy = {
    enable = true;
    clientID = "oauth2-proxy";
    email.domains = ["*"];
    httpAddress = "127.0.0.1:4180";

    # NOTE: this contains all the config that doesn't have a baked in nix config option
    keyFile = config.sops.templates."oauth2_proxy_env".path;

    # these are the virtual hosts protected by oauth2-proxy
    provider = "keycloak-oidc";
    reverseProxy = true;
    setXauthrequest = true;
  };
}
