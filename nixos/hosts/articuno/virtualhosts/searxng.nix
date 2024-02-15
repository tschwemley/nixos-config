let 
  # TODO: get this in a smarter way
  ip = "10.233.1.4";
in {
  services.nginx.virtualHosts."search.schwem.io" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://${ip}:8080";
      proxyWebsockets = true;
    };
  };
}
