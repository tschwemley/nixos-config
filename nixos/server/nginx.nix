{
  # networking.firewall.allowedTCPPorts = [8080];

  services.nginx = {
    enable = true;
    defaultListen = [
      {
        addr = "0.0.0.0";
        port = 8080;
        proxyProtocol = true;
      }
    ];
    recommendedProxySettings = true;
  };
}
