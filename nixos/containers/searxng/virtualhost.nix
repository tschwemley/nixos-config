let
  ip = "10.10.2.2";
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
