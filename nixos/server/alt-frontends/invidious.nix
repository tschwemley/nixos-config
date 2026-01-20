{
  self,
  config,
  lib,
  ...
}:
let
  address = "127.0.0.1";
  companionPort = lib.toInt self.lib.port-map.invidious-companion;
  domain = "yt.schwem.io";
  port = lib.toInt self.lib.port-map.invidious;
  serviceScale = config.services.invidious.serviceScale;
in
{
  # services.nginx.virtualHosts.${domain}.enableACME = lib.mkForce false;
  services.nginx = {
    virtualHosts.${domain}.locations = {
      # invidious main service
      "/".proxyPass =
        if serviceScale == 1 then "http://${address}:${toString port}" else "http://upstream-invidious";

      # invidious companion service
      "/companion".proxyPass = "http://${address}:${companionPort}";

      # ytproxy service
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
      # Generate as per https://docs.invidious.io/installation/
      registration_enabled = false;
      save_player_pos = true;
      statistics_enabled = true;

      db = {
        dbname = "invidious";
        user = "invidious";
      };

      invidious_companion = [
        { private_url = "http://${address}:${companionPort}/companion"; }
      ];
    };
  };

  sops =
    let
      format = "dotenv";
      group = "postgres";
      mode = "0440";
      sopsFile = self.lib.secret "server" "invidious.env";
    in
    {
      secrets =
        let
          mkSecret = key: {
            inherit
              format
              group
              key
              mode
              sopsFile
              ;
          };
        in
        {
          invidiousCompanionKey = mkSecret "SERVER_SECRET_KEY";
          invidiousDotenv = mkSecret;
          invidiousPostgresPassword = mkSecret "POSTGRES_PASSWORD";
        };
    };

  systemd.services.invidious = {
    serviceConfig = {
      SupplementaryGroups = "postgres";
    };
  };

  virtualisation.oci-containers.containers.invidious-companion = {
    image = "quay.io/invidious/invidious-companion:latest";
    ports = [ "127.0.0.1:8282:8282" ];

    environmentFiles = [
      config.sops.secrets.invidiousDotenv.path
    ];

    volumes = [
      "companioncache:/var/tmp/youtubei.js:rw"
    ];
    # environment = {
    #   # Same as configured on invidious above.
    #   # SERVER_SECRET_KEY = invidiousCompanionSecret;
    # };
  };
}
