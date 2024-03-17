let
  ip = "127.0.0.1";
  port = "9090";
in {
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations."/" = {
        proxyPass = "http://${ip}:${port}";
      };
    };
  };
}
