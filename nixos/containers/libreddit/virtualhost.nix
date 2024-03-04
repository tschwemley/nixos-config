let
  ip = "10.10.3.2";
  port = "8080";
in {
  services.nginx.virtualHosts."db.schwem.io" = {
    locations."/" = {proxyPass = "http://${ip}:${port}";};
  };
}
