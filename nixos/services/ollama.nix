{pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "11.0.0";
  };
}
