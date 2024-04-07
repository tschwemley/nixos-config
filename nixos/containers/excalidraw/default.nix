{
  imports = [./virtualhost.nix];

  virtualisation.oci-containers.containers.excalidraw = {
    autoStart = true;
    image = "excalidraw/excalidraw";
    ports = ["127.0.0.1:13000:3000"];
  };
}
