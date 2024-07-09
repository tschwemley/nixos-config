hostPath: {
  # imports = [./virtualhost.nix];

  # original docker command:
  # docker run -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm

  virtualisation.oci-containers.containers.ollama = {
    autoStart = true;
    image = "ollama/ollama:rocm";
    extraOptions = ["--device=/dev/kfd" "--device=/dev/dri"];
    ports = ["11434:11434"];
    volumes = ["${hostPath}:/root/.ollama"];
  };
}
