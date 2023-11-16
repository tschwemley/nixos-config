{...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."machamp.schwem.io" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        # proxyWebsockets = true; # needed if you need to use WebSocket
        /*
         extraConfig =
        # required when the target is also TLS server with multiple hosts
        "proxy_ssl_server_name on;"
        +
        # required when the server wants to use HTTP Authentication
        "proxy_pass_header Authorization;";
        */
      };
      serverAliaes = ["build.schwem.io"];
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "me@tylerschwemley.com";
}
