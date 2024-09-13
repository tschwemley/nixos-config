{ config, ... }:
{
  services.nginx.virtualHosts."freetar.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${config.portMap.freetar}";
    };
  };

  virtualisation.oci-containers.containers."freetar" = {
    autoStart = true;
    image = "kmille2/freetar:latest";
    ports = [ "127.0.0.1:${config.portMap.freetar}:22000" ];
    extraOptions = [ "--pull=always" ];
  };
}
