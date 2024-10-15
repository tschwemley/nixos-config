{ config, ... }:
{
  services.nginx.virtualHosts."pinterest.schwem.io" = {
    locations = {
      "/".proxyPass = "http://127.0.0.1:${config.portMap.binternet}";

      "/robots.txt".root = "etc/nginx/static/";
    };
  };

  virtualisation.oci-containers.containers."binternet" = {
    autoStart = true;
    image = "ghcr.io/ahwxorg/binternet:latest";
    ports = [ "127.0.0.1:${config.portMap.binternet}:8080" ];
  };
}
