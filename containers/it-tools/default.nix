{
  imports = [./virtualhost.nix];

  virtualisation.oci-containers.containers.redlib = {
    autoStart = true;
    image = "corentinth/it-tools:latest";
    ports = ["127.0.0.1:7001:80"];
  };
}
