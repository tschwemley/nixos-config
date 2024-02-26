let
  # TODO: get this in a smarter way
  ip = "10.10.3.2";
  port = 3000;
in {
  services.nginx.virtualHosts."yt.schwem.io" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://${ip}:${toString port}";
    };
  };

  networking.firewall.allowedTCPPorts = [port];
}
