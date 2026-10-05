{ config, ... }:
{
  # NOTE:
  # Completion Sources:
  # - https://github.com/ocodo/ollama_zsh_completion
  #
  # TODO: move into more determistic/updateable structure? Or leave as-is and commit directly?

  home.file.".zsh_completions".source = ./completions;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = import ./aliases;

    autocd = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";

    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };

    initContent =
      # bash
      ''
        ${builtins.readFile ./functions.zsh}

        # ${builtins.readFile ./hooks.zsh}

        # help-bat-widget() {
        #   if [[ $BUFFER =~ "(^|[[:space:]])(--help|-h)([[:space:]]|$)" ]]; then
        #     BUFFER="$BUFFER | bat -pl help"
        #   fi
        #   zle accept-line
        # }
        # zle -N help-bat-widget
        # bindkey '^M' help-bat-widget  # Binds to Enter
      '';

    # TODO: choose to keep one of these since home-manager decided to fuck around w/ this setting

    # To silence this warning and lock in the current behavior, set:
    dotDir = config.home.homeDirectory;

    # To adopt the new behavior (XDG config directory), set:
    # dotDir = "${config.xdg.configHome}/zsh";

  };
}
