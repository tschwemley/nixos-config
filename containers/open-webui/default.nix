hostPath: {
  virtualisation.oci-containers.containers = {
    open-webui = {
      autoStart = true;
      image = "ghcr.io/open-webui/open-webui:main";
      environment = {
        ENV = "dev";
        WEBUI_AUTH = "False";
      };
      extraOptions = [
        "--network=host"
        "--pull=always"
      ];
      # TODO: wrangle with nixos podman networking
      # ports = [ "0.0.0.0:8080:8080" ];
      volumes = [ "${hostPath}/state:/app/backend/data" ];
    };

    open-webui-pipelines = {
      autoStart = true;
      image = "ghcr.io/open-webui/pipelines:main";
      extraOptions = [
        "--network=host"
        "--pull=always"
      ];
      # TODO: wrangle with nixos podman networking
      # ports = [ "0.0.0.0:9099:9099" ];
      volumes = [ "${hostPath}/pipelines:/app/backend/data" ];
    };
  };
}
