{self, ...}: {
  services.nginx.virtualHosts."draw.schwem.io" = {
    locations = {
      "/".proxyPass = "http://127.0.0.1:${self.lib.port-map.excalidraw}";

      "/robots.txt".root = "/etc/nginx/static/";
    };
  };

  virtualisation.oci-containers.containers.excalidraw = {
    autoStart = true;
    image = "excalidraw/excalidraw:latest";
    ports = ["127.0.0.1:${self.lib.port-map.excalidraw}:80"];
    extraOptions = ["--pull=always"];
  };
}
