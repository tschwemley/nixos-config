{config, ...}: let
  host = "127.0.0.1";
  web-user = config.services.calibre-web.user;
in {
  services = {
    calibre-server = {
      inherit host;

      enable = true;
      port = config.variables.ports.calibre-server;
    };

    calibre-web = {
      enable = true;
      enableBookUploading = true;
      listen.ip = host;
    };
  };

  systemd.tmpfiles.rules = ["d /storage/media/books/calibre-web 0770 ${web-user} ${web-user} - -"];
}
