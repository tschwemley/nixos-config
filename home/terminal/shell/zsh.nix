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
      # [[ ! -d  ~/.zsh-completions ]] && mkdir ~/.zsh-completions
      # fpath+=~/.zsh-completions
      #
      # [[ ! -f ~/.zsh-completions/_podman ]] && ${pkgs.podman}/bin/podman completion zsh > ~/.zsh-completions/_podman
      # compdef _podman podman

      autoload -U compinit 


      #source <(glow completion zsh); compdef _glow glow
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
