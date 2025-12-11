{
  self,
  config,
  lib,
  ...
}:
let
  domain = "yt.schwem.io";
in
{
  services.nginx.virtualHosts.${domain}.enableACME = lib.mkForce false;

  services.invidious = {
    inherit domain;

    enable = true;

    http3-ytproxy.enable = true;
    nginx.enable = false;
    port = lib.toInt self.lib.port-map.invidious;

    database = {
      host = "localhost";
      passwordFile = config.sops.secrets.invidiousPostgresPassword.path;
    };

    # REF:: https://github.com/iv-org/invidious/blob/master/config/config.example.yml
    settings = {
      banner = "nyx nyx nyx";
      continue = true;
      dark_mode = "dark";
      registration_enabled = false;
      save_player_pos = true;
      statistics_enabled = true;

      db = {
        dbname = "invidious";
        user = "invidious";
      };
    };
  };

  sops.secrets.invidiousPostgresPassword = {
    group = "postgres";
    key = "postgres_password";
    mode = "0440";
    sopsFile = self.lib.secret "server" "invidious.yaml";
  };

  systemd.services.invidious = {
    serviceConfig = {
      SupplementaryGroups = "postgres";
    };
  };
}
