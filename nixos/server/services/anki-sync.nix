{config, ...}: {
  services = {
    anki-sync-server = {
      enable = true;
    };

    nginx.virtualHosts."anki.schwem.io".locations = {
      "/".proxyPass = "http://127.0.0.1:${toString config.services.anki-sync-server.port}";
    };
  };
}
