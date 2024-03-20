{config, ...}: let
  hostName = config.networking.hostName;
  tailnetUrl = "wyvern-map.ts.net";
in {
  services.nginx.virtualHosts."files.schwem.io" = {
    # filer
    locations."/" = {
      proxyPass = "http://${hostName}:9336";
      proxyWebsockets = true;
    };

    # volumes
    locations."/jolteon" = {
      proxyPass = "http://jolteon.${tailnetUrl}:9334/ui";
      proxyWebsockets = true;
    };

    locations."/moltres" = {
      proxyPass = "http://moltres.${tailnetUrl}:9334/ui";
      proxyWebsockets = true;
    };
  };
}
