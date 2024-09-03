{config, ...}: {
  services.nginx = {
    virtualHosts."so.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${config.portMap.anonymous-overflow}";
      };
    };
  };
}
