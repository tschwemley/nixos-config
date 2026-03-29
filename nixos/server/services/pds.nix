{
  self,
  lib,
  ...
}:
let
  listenAddr = "127.0.0.1";
  port = self.lib.port-map.bluesky-pds;
  portInt = lib.toInt port;
in
{
  services = {
    nginx.virtualHosts."pds.schwem.io" = {
      locations =
        let
          proxyPass = "http://${listenAddr}:${port}";
        in
        {
          "/xrpc" = { inherit proxyPass; };
          "/api/" = { inherit proxyPass; };
        };
    };

    bluesky-pds = {
      enable = true;
      settings = {
        PDS_HOSTNAME = "pds.schwem.io";
        PORT = portInt;
      };
    };
  };
}
