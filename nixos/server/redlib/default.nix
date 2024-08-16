let
  address = "127.0.0.1";
  port = 8180;
in {
  imports = [./virtualhost.nix];

  services.redlib = {
    inherit address port;
    enable = true;
    openFirewall = true;
  };

  systemd.services.redlib = {
    environment = {
      REDLIB_DEFAULT_THEME = "gruvboxdark";
      REDLIB_DEFAULT_SHOW_NSFW = "on";
      REDLIB_DEFAULT_USE_HLS = "on";
      REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
      # see: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
    };
  };
}
