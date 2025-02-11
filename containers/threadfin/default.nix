{self, ...}: {
  services.nginx = {
    virtualHosts."threadfin.schwem.io" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${self.lib.port-map.threadfin}";
        proxyWebsockets = true;
      };
    };
  };

  virtualisation.oci-containers.containers."threadfin" = {
    autoStart = true;
    image = "fyb3roptik/threadfin:latest";
    extraOptions = ["--pull=always"];
    ports = ["127.0.0.1:${self.lib.port-map.threadfin}:34400"];
  };
}
