{pkgs, ...}: {
  home.packages = with pkgs; [
    lmstudio
    mods
    ollama
  ];
}
