{config, ...}: let
  stateDir = "/var/lib/sillytavern";
in {
  systemd.tmpfiles.rules = ["d ${stateDir} 0770 root users - -"];

  virtualisation.oci-containers.containers.silly-tavern = {
    autoStart = true;
    image = "ghcr.io/sillytavern/sillytavern:latest";
    # extraOptions = ["--network=host"];
    ports = ["127.0.0.1:${config.variables.ports.silly-tavern}:8000"];
    volumes = [
      "${stateDir}/config:/home/node/app/config"
      "${stateDir}/data:/home/node/app/data"
      "${stateDir}/plugins:/home/node/app/plugins"
    ];
  };
}
# original docker command:
# docker run -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm
