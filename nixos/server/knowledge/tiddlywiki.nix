{config, ...}: {
  services.tiddlywiki = {
    enable = true;
    listenOptions = {
      # for available options see: https://tiddlywiki.com/#WebServer
      port = config.portMap.tiddlywiki;
    };
  };
}
