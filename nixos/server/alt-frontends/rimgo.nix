{
  self,
  lib,
  ...
}: {
  services.nginx.virtualHosts."rimgo.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${self.lib.port-map.rimgo}";
    };
  };

  services.rimgo = {
    enable = true;
    settings.PORT = lib.strings.toInt self.lib.port-map.rimgo;
  };
}
