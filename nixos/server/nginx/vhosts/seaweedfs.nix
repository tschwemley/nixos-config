let
  tailnetUrl = "wyvern-map.ts.net";
in {
  services.nginx.virtualHosts."files.schwem.io" = {
    # master
    locations."/" = {
      proxyPass = "http://moltres.${tailnetUrl}:9333";
      proxyWebsockets = true;
    };

    # filers
    locations."/lake" = {
      proxyPass = "http://jolteon.${tailnetUrl}:9336";
      proxyWebsockets = true;
    };

    locations."/moltres" = {
      proxyPass = "http://moltres.${tailnetUrl}:9336";
      proxyWebsockets = true;
    };
  };
}
