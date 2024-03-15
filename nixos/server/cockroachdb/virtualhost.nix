let
  ip = "127.0.0.1";
  port = "26080";
in {
  services.nginx.virtualHosts."db.schwem.io" = {
    locations."/articuno" = {
      proxyPass = "http://${ip}:${port}";
      proxyWebsockets = true;
    };
  };
}
