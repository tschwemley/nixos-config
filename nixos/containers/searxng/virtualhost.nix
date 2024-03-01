let
  ip = "10.10.2.2";
  port = "8080";
in {
  services.nginx.virtualHosts."search.schwem.io" = {
    locations."/" = {
      proxyPass = "http://${ip}:${port}";
      proxyWebsockets = true;
    };
  };
}
