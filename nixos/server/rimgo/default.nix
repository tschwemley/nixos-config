{ config, lib, ... }:
{
  services.nginx.virtualHosts."rimgo.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${config.portMap.rimgo}";
    };
  };

  services.rimgo = {
    enable = true;
    settings.PORT = lib.strings.toInt config.portMap.rimgo;
  };
}
