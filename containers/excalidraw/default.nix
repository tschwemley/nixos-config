{ config, ... }:
{
  services.nginx.virtualHosts."draw.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${config.portMap.excalidraw}";
    };
  };

  virtualisation.oci-containers.containers.excalidraw = {
    autoStart = true;
    image = "excalidraw/excalidraw:latest";
    ports = [ "127.0.0.1:${config.portMap.excalidraw}:80" ];
    extraOptions = [ "--pull=always" ];
  };
}
