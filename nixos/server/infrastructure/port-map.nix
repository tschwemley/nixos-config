{lib, ...}: {
  options.portMap = with lib;
    mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Map of server app/service name to port(s) used. Used to avoid collisions.";
    };

  config.portMap = {
    anonymous-overflow = "8010";
    binternet = "8009";
    dashboard = "6980";
    excalidraw = "8380";
    freetar = "22000";
    forgejo = "8020";
    invidious = "3100";
    it-tools = "7001";
    nginx-sso = "8082";
    nzbhydra2 = "5076";
    oidcsso = "1337";
    priviblur = "8040";
    proxitok = "8050";
    qtbittorrentWeb = "8880";
    qtbittorrentTorrent = "8881";
    redlib = "8180";
    rimgo = "8030";
    sabnzbd = "8314";
    safetwitch-frontend = "8280";
    safetwitch-backend = "7100";
    scribe = "7000";
    searxng = "8888";
    stash = "6969";
    threadfin = "34400";
    tiddlywiki = "4242";
    webhooks = "7780";
  };
}
