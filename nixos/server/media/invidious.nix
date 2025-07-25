{
  self,
  config,
  lib,
  ...
}: {
  services.invidious = {
    enable = true;
    domain = "yt.schwem.io";
    nginx.enable = true;
    port = lib.toInt config.variables.ports.invidious;

    database = {
      host = "127.0.0.1";
      passwordFile = config.sops.secrets.invidiousPostgresPassword.path;
    };

    settings = {
      # domain = "yt.schwem.io";
      db = {
        dbname = "invidious";
        user = "invidious";
      };
    };

    # uncomment this if having trouble playing certain videos
    # sig-helper = {
    #   enable = true;
    #   listenAddress = "127.0.0.1:${config.variables.ports.invidiousSigHelper}";
    # };
  };

  sops.secrets.invidiousPostgresPassword = {
    key = "postgres_password";
    sopsFile = self.lib.secret "server" "invidious.yaml";
  };
}
