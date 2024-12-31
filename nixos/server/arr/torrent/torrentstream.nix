{
  services = {
    # nginx.virtualHosts."torrentstream.schwem.io".locations = {
    #   "/".proxyPass = config.services.torrentstream.port;
    # };

    torrentstream.enable = true;
  };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/tiddlywiki/tiddlywiki.info 0644 tiddlywiki tiddlywiki - ${./tiddlywiki.info}"
  ];
}
