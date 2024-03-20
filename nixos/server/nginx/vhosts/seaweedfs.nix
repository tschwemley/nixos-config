{config, ...}: let
  hostName = config.networking.hostName;
  tailnetUrl = "wyvern-map.ts.net";
in {
  services.nginx.virtualHosts."files.schwem.io" = {
    # master
    locations."/" = {
      proxyPass = "http://moltres.${tailnetUrl}:9333";
      proxyWebsockets = true;
      extraConfig = ''
        include ${config.sops.templates.nginx_allow_secure.path};
      '';
    };

    # volume
    locations."/${hostName}/ui/index.html" = {
      proxyPass = "http://${hostName}.${tailnetUrl}:9334/index.html";
      proxyWebsockets = true;
      extraConfig = ''
        include ${config.sops.templates.nginx_allow_secure.path};
      '';
    };

    # filers
    locations."/lake" = {
      proxyPass = "http://jolteon.${tailnetUrl}:9336";
      proxyWebsockets = true;
      extraConfig = ''
        include ${config.sops.templates.nginx_allow_secure.path};
      '';
    };

    locations."/moltres" = {
      proxyPass = "http://moltres.${tailnetUrl}:9336";
      proxyWebsockets = true;
      extraConfig = ''
        include ${config.sops.templates.nginx_allow_secure.path};
      '';
    };
  };
}
