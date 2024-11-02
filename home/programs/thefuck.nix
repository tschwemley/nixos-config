{
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh.shellAliases.fk = "fuck";
}
