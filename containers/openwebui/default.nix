hostPath: {
  virtualisation.oci-containers.containers.open-webui = {
    autoStart = true;
    image = "ghcr.io/open-webui/open-webui:main";
    extraOptions = [
      "--network=host"
      "--pull=always"
    ];
    # ports = [ "0.0.0.0:3333:8080" ];
    volumes = [ "${hostPath}:/app/backend/data" ];
  };
}
