# function highlight-help-output() {
#     # if [[ "$1" == *"--help"* || "$1" == *" -h"* ]]; then
#     if [[ "$1" == *"--help"* ]]; then
# 		# $1 | bat -l help
# 		# echo "\$1: $1"
# 		# cmd=${1/ */}
# 		# args=${1/$cmd/}
# 		# echo "cmd: $cmd"
# 		# echo "args: $args"
# 		# "$cmd $args" | bat -pl help
#
#         # # Execute the command and pipe through bat
#         "${(Q)1}" | bat --plain --language=help
#
#         # Prevent the original command from executing
#         return 1
#     fi
# }

# Register the hook
autoload -Uz add-zsh-hook

add-zsh-hook preexec highlight-help-output

# highlight-help-output() {
# 	# echo $1
# 	# echo "----"
# 	# return 69
# 	# local cmd_str="$1"
# 	# # Check if the command string contains --help or -h and is not just a help
# 	# flag by itself
# 	# if [[ "$cmd_str" == *"--help"* || "$cmd_str" == *" -h"* ]] && [[
# 	# 	"$cmd_str" != "--help" ]] && [[ "$cmd_str" != "-h" ]]; then
# 	# 	# Extract the base command name (e.g., 'mycli')
# 	# 	local base_cmd=$(echo "$cmd_str" | cut -d' ' -f1)
# 	#
# 	# 	# Check if the base command is actually an executable
# 	# 	if type "$base_cmd" &>/dev/null; then
# 	# 		# Execute the command with its arguments and pipe through bat
# 	# 		eval "$cmd_str" | bat --plain --language=help
# 	# 		# Prevent the original command from executing
# 	# 		return 1
# 	# 	fi
# 	# fi
# }
