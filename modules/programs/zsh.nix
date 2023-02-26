{ config, ... }:
{
  programs.zsh.enable = true;
  programs.zsh.autocd = true;
  programs.zsh.defaultKeymap = "vicmd";
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.history = {
      extended = true; # store timestamps w/ history
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  #programs.zsh.shellAliases = shellAliases;
}
