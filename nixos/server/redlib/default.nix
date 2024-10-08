{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  address = "127.0.0.1";
  port = lib.strings.toInt config.portMap.redlib;
in
{
  services = {
    nginx.virtualHosts."reddit.schwem.io" = {
      locations."/" = {
        proxyPass = "http://${address}:${config.portMap.redlib}";
      };
    };

    redlib = {
      enable = true;
      package = inputs.redlib-latest.packages.${pkgs.system}.default;

      inherit address port;

      openFirewall = true;
    };
  };

  systemd.services.redlib = {
    environment = {
      REDLIB_ROBOTS_DISABLE_INDEXING = "on";
      REDLIB_DEFAULT_THEME = "gruvboxdark";
      REDLIB_DEFAULT_SHOW_NSFW = "on";
      REDLIB_DEFAULT_USE_HLS = "on";
      REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
      # see: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
    };

    # TODO: remove this after upstream bug is fixed
    # BUG: https://github.com/redlib-org/redlib/issues/229
    # serviceConfig = {
    #   Restart = lib.mkDefault "always";
    #   RuntimeMaxSec = lib.mkDefault "300s";
    # };
  };
}
