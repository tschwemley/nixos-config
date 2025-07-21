{
  config,
  lib,
  ...
}: {
  services.invidious = {
    enable = true;
    domain = "yt.schwem.io";
    nginx.enable = true;
    port = lib.toInt config.variables.ports.invidious;

    settings = {
      # domain = "yt.schwem.io";
    };

    # uncomment this if having trouble playing certain videos
    # sig-helper = {
    #   enable = true;
    #   listenAddress = "127.0.0.1:${config.variables.ports.invidiousSigHelper}";
    # };
  };
}
