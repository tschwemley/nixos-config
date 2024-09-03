{config, ...}: {
  services.nginx = {
    virtualHosts."so.schwem.io" = {
      locations."/" = {
        proxyPass = "https://127.0.0.1:${config.portMap.anonymous-overflow}";
      };
    };
  };
}
