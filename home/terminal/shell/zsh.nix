{ config, ... }:
let
  shellAliases = import ./aliases;
in
{
  home.file.".zsh_completions".source = ./completions;

  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    completionInit = ''
      fpath+=~/.zsh_completions
      autoload -U compinit && compinit 
    '';
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };
    initExtra = ''
      source ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh
      export PATH=$PATH:${config.home.profileDirectory}/bin

      # additional funcs
      func tbat() {
        tail -f "$1" | bat --paging=never -l log
      }
    '';
  };
}
