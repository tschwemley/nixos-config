{pkgs, ...}: {
  imports = [./ollama.nix];

  home.packages = with pkgs; [
    lmstudio
    mods
  ];
}
