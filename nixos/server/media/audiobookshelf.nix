{ self, ... }:
{
  services = {
    oidcproxy.protectedHosts."audiobook.schwem.io" = {
      # allowedGroups = ["admin"];
      allowedRealmRoles = [ "audiobookshelf" ];
      upstream = "http://audiobookshelf";
    };

    nginx.upstreams.audiobookshelf.servers = {
      "127.0.0.1:${self.lib.port-map.audiobookshelf}" = { };
    };

    audiobookshelf = {
      enable = true;
      port = self.lib.port-map.audiobookshelf;
    };
  };
}
