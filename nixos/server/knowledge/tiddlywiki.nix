{config, ...}: {
  services = {
    # nginx.virtualHosts.jolteon = {
    #   locations."/".proxyPass = "127.0.0.1:${config.portMap.tiddlywiki}";
    # };

    tiddlywiki = {
      enable = true;
      listenOptions = {
        # for available options see: https://tiddlywiki.com/#WebServer
        port = config.portMap.tiddlywiki;
      };
    };
  };
}
