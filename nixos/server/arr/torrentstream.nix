{ config, ... }:
{
  services = {
    nginx.virtualHosts."torrentstream.schwem.io".locations = {
      "/" =
        {
        };
    };

    torrentstream.enable = true;
  };
}
