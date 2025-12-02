{
  imports = [ ./docker-compose.nix ];

  services.nginx.virtualHosts."quora.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:13000";
    };
  };
}
