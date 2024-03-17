{config, ...}: let
  ip = "${config.networking.hostName}.wyvern-map.ts.net";
  port = "26080";
in {
  services.nginx = {
    upstreams.cockroach-web.servers = {
      "${config.networking.hostName}.wyvern-map.ts.net:26080" = {};
    };

    virtualHosts."db.schwem.io" = {
      locations."/" = {
        proxyPass = "cockroach-web";
        # proxyPass = "https://${ip}:${port}";
        # proxyWebsockets = true;
      };
    };
  };
}
