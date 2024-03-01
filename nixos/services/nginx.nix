{
  networking.firewall.allowedTCPPorts = [8080];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    defaultHTTPListenPort = 8080;
  };
}
