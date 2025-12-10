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

    database.passwordFile = config.sops.secrets.invidiousPostgresPassword.path;
    http3-ytproxy.enable = true;
    nginx.enable = false;
    port = lib.toInt self.lib.port-map.invidious;

    # REF:: https://github.com/iv-org/invidious/blob/master/config/config.example.yml
    settings = {
      banner = "nyx nyx nyx";
      continue = true;
      dark_mode = "dark";
      registration_enabled = false;
      save_player_pos = true;
      statistics_enabled = true;

      db = {
        name = "invidious";
        user = "invidious";
      };
    };

  };

  sops.secrets.invidiousPostgresPassword = {
    group = "postgres";
    key = "postgres_password";
    mode = "0400";
    owner = "postgres";
    sopsFile = self.lib.secret "server" "invidious.yaml";
  };
}
