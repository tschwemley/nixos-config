{pkgs, ...}: {
  imports = [./llm.nix];

  home.packages = with pkgs; [
    lmstudio
    mods
  ];
}
