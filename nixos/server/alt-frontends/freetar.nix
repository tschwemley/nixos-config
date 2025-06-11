{config, ...}: let
  port = config.variables.ports.freetar;
in {
  services.nginx = {
    virtualHosts."freetar.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${port}";
        proxyWebsockets = true;
      };
    };
  };

  virtualisation.oci-containers.containers."freetar" = {
    autoStart = true;
    image = "kmille2/freetar";
    extraOptions = ["--pull=always"];
    ports = ["127.0.0.1:${port}:${port}"];
  };
}
