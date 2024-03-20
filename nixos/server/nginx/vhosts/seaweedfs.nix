{
  services.nginx.virtualHosts."files.schwem.io" = {
    # filer
    locations."/" = {
      proxyPass = "http://127.0.0.1:9336";
      proxyWebsockets = true;
    };

    # volumes
    locations."/jolteon" = {
      proxyPass = "http://moltres:9334/ui";
      proxyWebsockets = true;
    };

    locations."/moltres" = {
      proxyPass = "http://moltres:9334/ui";
      proxyWebsockets = true;
    };
  };
}
