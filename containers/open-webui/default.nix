hostPath: {
  virtualisation.oci-containers.containers = {
    open-webui = {
      autoStart = true;
      image = "ghcr.io/open-webui/open-webui:main";
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

  # docker run -d -p 9099:9099 --add-host=host.docker.internal:host-gateway -e PIPELINES_URLS="https://github.com/open-webui/pipelines/blob/main/examples/filters/detoxify_filter_pipeline.py" -v pipelines:/app/pipelines --name pipelines --restart always ghcr.io/open-webui/pipelines:main
}
