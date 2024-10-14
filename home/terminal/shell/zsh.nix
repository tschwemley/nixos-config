{ config, pkgs, ... }:
let
  shellAliases = import ./aliases;
in
{
  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    completionInit = ''
      [[ ! -d  ~/.zsh-completions ]] && mkdir ~/.zsh-completions
      fpath+=~/.zsh-completions
      autoload -U compinit 
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
    sessionVariables = {
      VISUAL = "nvim";
    };
  };
}
