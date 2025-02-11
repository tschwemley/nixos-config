{self, ...}: {
  services.nginx.virtualHosts."freetar.schwem.io" = {
    locations = {
      "/".proxyPass = "http://127.0.0.1:${self.lib.port-map.freetar}";

      "/robots.txt".root = "/etc/nginx/static/";
    };
  };

  virtualisation.oci-containers.containers."freetar" = {
    autoStart = true;
    image = "kmille2/freetar:latest";
    ports = ["127.0.0.1:${self.lib.port-map.freetar}:22000"];
    extraOptions = ["--pull=always"];
  };
}
