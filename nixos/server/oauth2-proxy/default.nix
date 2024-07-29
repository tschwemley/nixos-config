{config, ...}: {
  imports = [
    ./configuration.nix
    # ./virtualhost.nix
  ];

  networking.firewall.allowedTCPPorts = [4180];

  services.oauth2-proxy = {
    enable = true;
    clientID = "oauth2-proxy";
    cookie.domain = ".schwem.io";
    email.domains = ["*"];
    # httpAddress = "http://127.0.0.1:4180";
    httpAddress = "http://0.0.0.0:4180";

    # NOTE: this contains all the config that doesn't have a baked in nix config option
    keyFile = config.sops.templates."oauth2_proxy_env".path;

    nginx = {
      domain = "auth.schwem.io";
      # NOTE:this might need to be changed
      proxy = config.services.oauth2-proxy.httpAddress;
      virtualHosts = [
        "monitor.schwem.io"
      ];
    };

    provider = "keycloak-oidc";
    reverseProxy = true;
    setXauthrequest = true;
  };
}
