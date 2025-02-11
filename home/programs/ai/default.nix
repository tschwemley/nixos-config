{pkgs, ...}: {
  imports = [./ollama.nix];

  home.packages = with pkgs; [
    dbgate
    lmstudio
    mods
  ];
}
