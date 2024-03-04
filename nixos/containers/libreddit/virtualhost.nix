let
  ip = "10.10.3.2";
  port = "8080";
in {
  services.nginx.virtualHosts."reddit.schwem.io" = {
    locations."/" = {proxyPass = "http://${ip}:${port}";};
  };
}
