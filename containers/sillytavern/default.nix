hostPath: {
  # imports = [./virtualhost.nix];

  # original docker command:
  # docker run -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm

  virtualisation.oci-containers.containers.silly-tavern = {
    autoStart = true;
    image = "ghcr.io/sillytavern/sillytavern:latest";
    extraOptions = ["--network=host"];
    ports = ["8000:8000"];
    volumes = [
      "${hostPath}/config:/home/node/app/config"
      "${hostPath}/config:/home/node/app/data"
      "${hostPath}/config:/home/node/app/plugins"
    ];
  };
}

# version: "3"
# services:
#   sillytavern:
#     build: ..
#     container_name: sillytavern
#     hostname: sillytavern
#     image: ghcr.io/sillytavern/sillytavern:latest
#     ports:
#       - "8000:8000"
#     volumes:
#       - "./config:/home/node/app/config"
#       - "./data:/home/node/app/data"
#       - "./plugins:/home/node/app/plugins"
#     restart: unless-stopped
