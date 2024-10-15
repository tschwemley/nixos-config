{ config, ... }:
{
  services.nginx.virtualHosts."it-tools.schwem.io" = {
    locations = {
      "/".proxyPass = "http://127.0.0.1:${config.portMap.it-tools}";

      "/robots.txt".root = "etc/nginx/static/";
    };
  };

  virtualisation.oci-containers.containers."it-tools" = {
    autoStart = true;
    image = "corentinth/it-tools:latest";
    ports = [ "127.0.0.1:${config.portMap.it-tools}:80" ];
  };
}
