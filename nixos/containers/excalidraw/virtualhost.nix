let
  ip = "127.0.0.1";
  port = "13000";
in {
  services.nginx.virtualHosts."draw.schwem.io" = {
    locations."/" = {proxyPass = "http://${ip}:${port}";};
  };
}
