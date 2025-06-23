{
  self,
  lib,
  ...
}: let
  address = "127.0.0.1";
in {
  nixpkgs.overlays = [self.overlays.redlib];

  services = {
    nginx.virtualHosts."reddit.schwem.io" = {
      locations."/" = {
        proxyPass = "http://${address}:${self.lib.port-map.redlib}";
      };
    };

    redlib = {
      enable = true;

      inherit address;
      port = lib.toInt self.lib.port-map.redlib;
      settings = {
        REDLIB_ROBOTS_DISABLE_INDEXING = "on";
        REDLIB_DEFAULT_THEME = "gruvboxdark";
        REDLIB_DEFAULT_SHOW_NSFW = "on";
        REDLIB_DEFAULT_USE_HLS = "on";
        REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
      };
    };
  };

  # TODO: this should now be resolved... delete after confirming
  # NOTE: using official container build instead of nix pkg (or custom package) because:
  #         1. redlib is prone to breaking changes from reddit
  #         2. it's updated the most regularly by the maintainer
  # virtualisation.oci-containers.containers."redlib" = {
  #   autoStart = true;
  #   image = "quay.io/redlib/redlib:latest";
  #   ports = ["${listenAddress}:${self.lib.port-map.redlib}:8080"];
  #   extraOptions = ["--pull=always"];
  #   environment = {
  #     # see: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
  #     REDLIB_ROBOTS_DISABLE_INDEXING = "on";
  #     REDLIB_DEFAULT_THEME = "gruvboxdark";
  #     REDLIB_DEFAULT_SHOW_NSFW = "on";
  #     REDLIB_DEFAULT_USE_HLS = "on";
  #     REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
  #   };
  # };
}
