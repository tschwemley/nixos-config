{
  services.nginx.virtualHosts."jellyfin.schwem.io" = {
    locations."/" = {
      proxyPass = "http://10.10.3.2:8096";
    };
  };
}
