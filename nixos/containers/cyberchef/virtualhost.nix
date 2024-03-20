let
  ip = "10.10.4.2";
  port = "80";
in {
  services.nginx.virtualHosts."cyberchef.schwem.io" = {
    locations."/" = {
      proxyPass = "http://${ip}:${port}";
    };
  };
}
