{
  home.file.".zsh_completions".source = ./completions;

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    shellAliases = import ./aliases;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };

    initContent =
      # bash
      ''
        ${builtins.readFile ./functions.zsh}

        function highlight-help-output() {
            if [[ "$1" == *"--help"* || "$1" == *" -h"* ]]; then
                # Execute the command and pipe through bat
                "''$1" | bat --plain --language=help

                # Prevent the original command from executing
                return 1
            fi
        }

        # Register the hook
        autoload -Uz add-zsh-hook

        add-zsh-hook preexec highlight-help-output
      '';
  };
}
