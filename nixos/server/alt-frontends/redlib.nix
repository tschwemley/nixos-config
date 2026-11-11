{
  self,
  config,
  lib,
  pkgs,
  ...
}:
{
  services = {
    nginx.virtualHosts."reddit.schwem.io" = {
      locations."/" = {
        proxyPass = "http://unix:${config.services.anubis.instances.redlib.settings.BIND}";
      };
    };

    redlib = {
      enable = true;

      address = "127.0.0.1";
      package = self.packages.${lib.system pkgs}.redlib;
      port = lib.toInt lib.port-map.redlib;

      # REF: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
      settings = {
        REDLIB_DB_PATH = "/tmp/redlib.db";

        REDLIB_DEFAULT_THEME = "gruvboxdark";
        REDLIB_DEFAULT_SHOW_NSFW = "on";
        REDLIB_DEFAULT_USE_HLS = "on";
        REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";

        REDLIB_ROBOTS_DISABLE_INDEXING = "on";
      };
    };
  };
}
