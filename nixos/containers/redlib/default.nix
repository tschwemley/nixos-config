{
  imports = [./virtualhost.nix];

  virtualisation.oci-containers.containers.redlib = {
    autoStart = true;
    image = "quay.io/redlib/redlib";
    # see: https://github.com/redlib-org/redlib/?tab=readme-ov-file#default-user-settings
    environment = {
      REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
      REDLIB_DEFAULT_SHOW_NSFW = "on";
      REDLIB_DEFAULT_THEME = "gruvboxdark";
      REDLIB_DEFAULT_USE_HLS = "on";
      # REDLIB_DEFAULT_WIDE = "on";
    };
    ports = ["127.0.0.1:8180:8080"];
  };
}
