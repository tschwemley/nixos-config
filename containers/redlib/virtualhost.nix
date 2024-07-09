let
  ip = "127.0.0.1";
  port = "8180";
in {
  services.nginx.virtualHosts."reddit.schwem.io" = {
    locations."/" = {proxyPass = "http://${ip}:${port}";};
  };
}
