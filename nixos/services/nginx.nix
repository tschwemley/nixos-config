{
  networking.firewall.allowedTCPPorts = [8080];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    # defaultHTTPListenPort = 8080;
    defaultListen = [
      {
        addr = "127.0.0.1";
        port = 8080;
        proxyProtocol = true;
      }
    ];
  };
}
