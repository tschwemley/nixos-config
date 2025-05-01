{self, config, ...}: {
  services = {
    anki-sync-server = {
      enable = true;

      users = [
        { username = "schwem"; passwordFile = "/run/secrets/anki_schwem_password"; }
      ];
    };

    nginx.virtualHosts."anki.schwem.io".locations = {
      "/".proxyPass = "http://127.0.0.1:${toString config.services.anki-sync-server.port}";
    };
  };

  sops.secrets."anki_schwem_password" = {
    mode = "0400";
    sopsFile = self.lib.secret "server" "anki.yaml";
  };
}
