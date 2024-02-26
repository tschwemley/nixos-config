{config, ...}: {
  services.invidious = {
    enable = true;
    domain = "yt.schwem.io";
    # http3-ytproxy.enable = true;
    hmacKeyFile = config.sops.secrets.hmacKey.path;
  };

  sops.secrets.hmacKey = {
    mode = "0444";
    sopsFile = ./secrets.yaml;
  };
}
