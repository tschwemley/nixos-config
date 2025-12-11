{
  self,
  config,
  lib,
  ...
}:
let
  address = "127.0.0.1";
  domain = "yt.schwem.io";
  port = lib.toInt self.lib.port-map.invidious;
  serviceScale = config.services.invidious.serviceScale;
in
{
  # services.nginx.virtualHosts.${domain}.enableACME = lib.mkForce false;
  services.nginx = {
    virtualHosts.${domain}.locations = {
      "/".proxyPass =
        if serviceScale == 1 then "http://${address}:${toString port}" else "http://upstream-invidious";

      # ytproxy
      "~ (^/videoplayback|^/vi/|^/ggpht/|^/sb/)".proxyPass =
        "http://unix:/run/http3-ytproxy/socket/http-proxy.sock";

      # TODO: delete me after confirming works
      # enableACME = lib.mkDefault true;
      # forceSSL = lib.mkDefault true;
    };

    upstreams = lib.mkIf (serviceScale > 1) {
      "upstream-invidious".servers = builtins.listToAttrs (
        builtins.genList (scaleIndex: {
          name = "${address}:${toString (port + scaleIndex)}";
          value = { };
        }) serviceScale
      );
    };
  };

  services.invidious = {
    inherit address domain port;

    enable = true;

    http3-ytproxy.enable = true;
    nginx.enable = false; # I configure this manually

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
