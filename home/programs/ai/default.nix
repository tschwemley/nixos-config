{pkgs, ...}: {
  imports = [
    ./mods.nix
    ./llm.nix
  ];

  # TODO: anything being kept move to appropriate sub-config file
  home.packages = with pkgs; [
    piper-tts
  ];
}
