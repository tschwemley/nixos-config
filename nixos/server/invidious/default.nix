{ config, ... }:
{
  services.invidious = {
    enable = true;
    domain = "yt.schwem.io";
    http3-ytproxy.enable = true;
    nginx.enable = true;
    port = config.portMap.invidious;
    settings = {
      banner = "nyx nyx nyx";
      continue = true;
      dark_mode = "dark";
      registration_enabled = false;
      save_player_pos = true;
      statistics_enabled = true;
    };
  };
}
