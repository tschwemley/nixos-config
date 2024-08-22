let
  ip = "127.0.0.1";
  port = "7001";
in {
  services.nginx.virtualHosts."it-tools.schwem.io" = {
    locations."/" = {proxyPass = "http://${ip}:${port}";};
  };
}
