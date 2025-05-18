{
  self,
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
          "127.0.0.1:${self.lib.port-map.tiddlywiki}" = {};
        };
      };
    };

    tiddlywiki = {
      enable = true;
      listenOptions = {
        # for available options see: https://tiddlywiki.com/#WebServer
        host = "127.0.0.1";
        port = self.lib.port-map.tiddlywiki;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/tiddlywiki/tiddlywiki.info 0644 - - - ${./tiddlywiki.info}"
  ];
}
