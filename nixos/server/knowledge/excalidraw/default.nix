{ config, ... }:
let
  port = config.variables.ports.excalidraw;
in
{
  services.nginx.virtualHosts."draw.schwem.io" = {
    locations = {
      "/".proxyPass = "http://127.0.0.1:${port}";

      "/robots.txt".root = "/etc/nginx/static/";
    };
  };

  virtualisation.oci-containers.containers.excalidraw = {
    autoStart = true;
    image = "excalidraw/excalidraw:latest";
    ports = [ "127.0.0.1:${port}:80" ];
    extraOptions = [ "--pull=always" ];
  };
}
