{config, ...}: {
  services = {
    nginx.virtualHosts."wiki.schwem.io" = {
      locations."/".proxyPass = "127.0.0.1:${config.portMap.tiddlywiki}";
    };

    tiddlywiki = {
      enable = true;
      listenOptions = {
        # for available options see: https://tiddlywiki.com/#WebServer
        host = "0.0.0.0";
        port = config.portMap.tiddlywiki;
      };
    };
  };

  systemd.tmpfiles.rules = ["d /var/lib/tiddlywiki 0755 root root - -"];
}
