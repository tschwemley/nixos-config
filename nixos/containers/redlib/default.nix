{
  imports = [./virtualhost.nix];

  virtualisation.oci-containers.containers.redlib = {
    autoStart = true;
    image = "quay.io/redlib/redlib";
    # see: https://github.com/redlib-org/redlib/?tab=readme-ov-file#default-user-settings
    environment = {
      REDLIB_HIDE_HLS_NOTIFICATION = "on";
      REDLIB_SHOW_NSFW = "on";
      REDLIB_THEME = "gruvboxdark";
      REDLIB_USE_HLS = "on";
      # REDLIB_WIDE = "on";
    };
    ports = ["127.0.0.1:8180:8080"];
  };
}
