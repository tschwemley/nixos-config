{pkgs, ...}: {
  home.packages = with pkgs; [
    ollama-rocm
  ];
}
