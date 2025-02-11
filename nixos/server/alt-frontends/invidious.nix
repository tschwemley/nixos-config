{
  self,
  lib,
  ...
}: let
  domain = "yt.schwem.io";
in {
  services.nginx.virtualHosts.${domain}.enableACME = lib.mkForce false;

  services.invidious = {
    inherit domain;

    enable = true;
    http3-ytproxy.enable = true;
    nginx.enable = true;
    port = self.lib.port-map.invidious;
    settings = {
      banner = "nyx nyx nyx";
      continue = true;
      dark_mode = "dark";
      db.name = "invidious";
      registration_enabled = false;
      save_player_pos = true;
      statistics_enabled = true;
    };
  };
}
