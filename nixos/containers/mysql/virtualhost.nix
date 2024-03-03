let
  ip = "10.90.1.2";
  port = "3306";
in {
  services.nginx.virtualHosts."db.schwem.io" = {
    listen = [
      {
        addr = "10.90.1.2";
        port = 3306;
      }
    ];
    locations."/" = {
      proxyPass = "tcp://${ip}:${port}";
      proxyWebsockets = true;
    };
  };
}
