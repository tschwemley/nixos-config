{ config, ... }:
{
  services = {
    nginx.virtualHosts."nzbhydra.schwem.io".locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:${config.portMap.nzbhydra2}";
      };
    };

    nzbhydra2.enable = true;
  };
}
