{config, ...}: let
  ip = "127.0.0.1";
  port = config.variables.ports.webhooks;
in {
  services = {
    nginx.virtualHosts."search.schwem.io".locations."/".proxyPass = "http://${ip}:${port}";

    webhook = {
      inherit ip port;
      enable = true;
      verbose = true; # true by default but I want to expose it here in case I want to disable
    };
  };
}
