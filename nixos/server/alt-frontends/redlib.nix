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
        REDLIB_DB_PATH = "/var/lib/redlib/redlib.db";

        REDLIB_DEFAULT_THEME = "gruvboxdark";
        REDLIB_DEFAULT_SHOW_NSFW = "on";
        REDLIB_DEFAULT_USE_HLS = "on";
        REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";

        REDLIB_ROBOTS_DISABLE_INDEXING = "on";
      };
    };
  };

  systemd.services.redlib = {
    preStart = ''
      ${pkgs.coreutils}/bin/touch /var/lib/redlib/redlib.db
    '';

    serviceConfig = {
      StateDirectory = "redlib";
      StateDirectoryMode = "0750";
      WorkingDirectory = "/var/lib/redlib";

      # Keep the syscall restrictions, but return "Operation not permitted"
      # rather than killing the process when a blocked syscall is attempted.
      SystemCallErrorNumber = "EPERM";
    };
  };
}
