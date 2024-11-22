{pkgs, ...}: {
  imports = [./ollama.nix];

  home.packages = with pkgs; [mods];
}
