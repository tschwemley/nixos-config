{config, ...}: {
  imports = [
    ./configuration.nix
    ./virtualhost.nix
  ];

  services.oauth2_proxy = {
    enable = true;
    clientID = "oauth2-proxy";
    email.domains = ["*"];
    httpAddress = "http://127.0.0.1:4180";

    # NOTE: this contains all the config that doesn't have a baked in nix config option
    keyFile = config.sops.templates."oauth2_proxy_env".path;

    # nginx = {
    #   # NOTE:this might need to be changed
    #   proxy = config.services.oauth2_proxy.httpAddress;
    #   virtualHosts = [
    #     "monitor.schwem.io"
    #   ];
    # };

    provider = "keycloak-oidc";
    reverseProxy = true;
    setXauthrequest = true;
  };
}
