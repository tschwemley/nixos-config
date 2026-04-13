{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  address = "127.0.0.1";
in
{
  services = {
    nginx.virtualHosts."reddit.schwem.io" = {
      locations."/" = {
        # proxyPass = "http://${address}${config.services.anubis.instances.redlib.settings.BIND}";
        proxyPass = "http://unix:${config.services.anubis.instances.redlib.settings.BIND}";
      };
    };

    redlib = {
      inherit address;

      enable = true;
      package = self.inputs.redlib.packages.${pkgs.stdenv.hostPlatform.system}.default;
      port = lib.toInt self.lib.port-map.redlib;

      # REF: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
      settings = {
        REDLIB_ROBOTS_DISABLE_INDEXING = "on";
        REDLIB_DEFAULT_THEME = "gruvboxdark";
        REDLIB_DEFAULT_SHOW_NSFW = "on";
        REDLIB_DEFAULT_USE_HLS = "on";
        REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
      };
    };
  };
}
