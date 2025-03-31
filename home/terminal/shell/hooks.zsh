# Check if help flag is present and pipe to bat
check-help-flag() {
    local cmd="$1"
	if [[ "$cmd" =~ '(^|[[:space:]])(--help|-h)([[:space:]]|$)' ]]; then
	# Extract the base command (without flags/args)
        local base_cmd="${cmd%% *}"
        # Run the command with --help and pipe to bat NOTE: make provides better highlighting
        eval "${cmd%%--help*}" --help | bat --plain --language=make
        return 1  # Skip original command execution
    fi

	# If no help flag, allow the command to proceed normally
    return 0
}

# Enable preexec modification
autoload -Uz add-zsh-hook

add-zsh-hook preexec check-help-flag
