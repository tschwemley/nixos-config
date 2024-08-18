{
  services.nginx.virtualHosts."jellyfin.schwem.io" = {
    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
    };
  };
}
