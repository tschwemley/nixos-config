{
  config,
  pkgs,
  ...
}: {
  imports = [./plugins.nix];

  environment.systemPackages = [pkgs.nodePackages.tiddlywiki];

  services = {
    oidcproxy.protectedHosts."wiki.schwem.io" = {
      allowedGroups = ["admin"];
      allowedRealmRoles = ["admin"];
      upstream = "http://tiddlywiki";
    };

    nginx.upstreams = {
      "tiddlywiki" = {
        servers = {
          "127.0.0.1:${config.portMap.tiddlywiki}" = {};
        };
      };
    };

    tiddlywiki = {
      enable = true;
      listenOptions = {
        # for available options see: https://tiddlywiki.com/#WebServer
        host = "127.0.0.1";
        port = config.portMap.tiddlywiki;
      };
    };
  };

  systemd = {
    services.tiddlywiki.environment = {
      TIDDLYWIKI_PLUGIN_PATH = "/var/lib/tiddlywiki/plugins";
    };

    tmpfiles.rules = [
      "L+ /var/lib/tiddlywiki/tiddlywiki.info 0644 tiddlywiki tiddlywiki - ${./tiddlywiki.info}"
    ];
  };
}
