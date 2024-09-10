{ config, ... }:
let
  ip = "127.0.0.1";
  port = toString config.services.grafana.settings.server.http_port;
in
{
  services.nginx = {
    virtualHosts."monitor.schwem.io" = {
      locations = {
        "/" = {
          proxyPass = "http://${ip}:${port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
