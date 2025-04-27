highlight-help-output() {
    if [[ "$1" == *"--help"* || "$1" == *" -h"* ]]; then
        # Execute the command and pipe through bat
        "${(Q)1}" | bat --plain --language=help

        # Prevent the original command from executing
        return 1
    fi
}

# Register the hook
autoload -Uz add-zsh-hook

add-zsh-hook preexec highlight-help-output
