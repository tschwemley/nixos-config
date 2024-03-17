{config, ...}: let
  ip = "${config.networking.hostName}.wyvern-map.ts.net";
  port = "26080";
in {
  services.nginx.virtualHosts."db.schwem.io" = {
    # sslCertificate = "/root/.config/cockroachdb/client.root.crt";
    # sslCertificateKey = "/root/.config/cockroachdb/client.root.key";
    locations."/" = {
      proxyPass = "http://${ip}:${port}";
      proxyWebsockets = true;
    };
  };
}
