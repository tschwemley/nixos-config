{pkgs, ...}: {
  home.packages = with pkgs; [
    ollama
    whisper-ctranslate2
  ];

  programs.zsh.shellAliases.whisper = "whisper-ctranslate2";
}
