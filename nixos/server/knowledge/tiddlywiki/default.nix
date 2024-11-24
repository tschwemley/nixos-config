{config, ...}: {
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

  systemd.tmpfiles.rules = [
    "d /var/lib/tiddlywiki 0755 root root - -"
    "f+ /var/lib/tiddlywiki/tiddlywiki.info tiddlywiki tiddlywiki - ${./tiddlywiki.info}"
  ];
}
