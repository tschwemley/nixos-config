# calculations from cli
c () { 
    local exp 
    (( $# > 0 )) && exp="$@" || read -r -p "expression: " exp
    wcalc -EE <<< "$exp"
}

jqkv() {
	[[ -z $1 ]] && echo "no file passed" && exit 1
	jq 'to_entries | .[] | "\(.key): \(.value)"' "$1"
}

# nix build with output of last error
nbuild() {
  nix build "$@" 2>/tmp/last-build.error.log
  $(tail -n1 /tmp/last-build.error.log | sed "s/.*\(nix log.*\)'./\1/")
}


# nix flake update 
nfu() { 
	nix flake update && git add flake.lock && git commit -m 'flake update' && git push origin main
}

npfgit() {
	# local url=${1:-""}
	# local rev=${2:-""}
	# [[ -z $url ]] && echo "no url passed" && exit
	# nix-prefetch-git --url $1 2>/dev/null | jq .hash | wl-copy
  local url=${1}
  local rev=${2}
  local nix_options=()
  local hash

  if [[ -z "$url" ]]; then
    echo "Error: No URL passed to npfgit." >&2
    return 1
  fi

  nix_options+=(--url "$url")
  if [[ -n "$rev" ]]; then
    nix_options+=(--rev "$rev")
  fi

  # Capture output to check for errors and parse
  # Using --json can be more reliable if available and nix-prefetch-git supports it well.
  # For now, sticking to original approach but capturing stdout for jq.
  # We also capture stderr from nix-prefetch-git to show it on failure.
  local prefetch_output
  local prefetch_stderr
  
  # Command substitution $(...) captures stdout. We need to redirect stderr.
  # Using process substitution for stderr capture or a temp file.
  # Simpler: just run and check status, then run again for jq if successful (less efficient).
  # Or, let stderr go to terminal if nix-prefetch-git fails.
  
  echo "Prefetching from $url ${rev:+"with revision $rev"}..."
  prefetch_output=$(nix-prefetch-git "${nix_options[@]}" 2> >(prefetch_stderr=$(cat); cat >&2))
  # Alternative to above stderr capture, if it's too complex:
  # prefetch_output=$(nix-prefetch-git "${nix_options[@]}" 2>/tmp/npfgit_error.log)
  # local nix_status=$?
  # prefetch_stderr=$(cat /tmp/npfgit_error.log)
  # rm -f /tmp/npfgit_error.log

  local nix_status=$?

  if [[ $nix_status -ne 0 ]]; then
    echo "Error: nix-prefetch-git failed (exit code $nix_status) for URL: $url" >&2
    # if [[ -n "$prefetch_stderr" ]]; then
    #   echo "Stderr from nix-prefetch-git:" >&2
    #   echo "$prefetch_stderr" >&2
    # fi
    return 1
  fi

  hash=$(echo "$prefetch_output" | jq -r .hash)
  local jq_status=$?

  if [[ $jq_status -ne 0 ]] || [[ -z "$hash" ]] || [[ "$hash" == "null" ]]; then
    echo "Error: Could not extract .hash using jq." >&2
    echo "Output from nix-prefetch-git:" >&2
    echo "$prefetch_output" >&2
    return 1
  fi

  echo "$hash" | wl-copy
  local wl_copy_status=$?

  if [[ $wl_copy_status -ne 0 ]]; then
    echo "Error: wl-copy failed to copy the hash." >&2
    echo "Hash was: $hash" # So user can still copy it manually
    return 1
  fi

  echo "Hash '$hash' copied to clipboard."
  return 0
}

rnum() {                                                      
	local min max
	echo $#
	if [ $# > 1 ]; then 
		min=$1
		max=$2
	else 
		min=0
		max=$1
	fi

	printf "min: %d; max: %d\n" min max

	echo $((RANDOM % (max - min + 1) + min))                  
}

# run command from nixpkgs via current system flake
run() {
  pkg=$1
  shift

  nix run github:nixos/nixpkgs/nixos-unstable#"$pkg" -- "$@"
}

srun() {
  pkg=$1
  shift

  sudo nix run github:nixos/nixpkgs/nixos-unstable#"$pkg" -- "$@"
}

# TODO: func needs fixed for extracting multiple keys. Not worth extra time when writing.
sops_extract() {
  # Assign all but the last argument as a secret key
  secretKeys=$(printf '"%s" ' "$\{@:1:$#-1}")


  # Assign the last argument as the secret path
  sopsFile="$\{*:$#}"
  echo "$sopsFile"

  # decrypt and extract the secret keys (`<str>% ` trims trailing space)
  sops -d --extract "'[$\{secretKeys% }]'" "$sopsFile"
}



# tail with bat
tailf() { tail -f "$1" | bat --paging=never -l log }

highlight-help-output() {
    # if [[ "$1" == *"--help"* || "$1" == *" -h"* ]]; then
    if [[ "$1" == *"--help"* ]]; then
		# $1 | bat -l help
		# echo "\$1: $1"
		# cmd=${1/ */}
		# args=${1/$cmd/}
		# echo "cmd: $cmd"
		# echo "args: $args"
		# "$cmd $args" | bat -pl help

        # # Execute the command and pipe through bat
        "${(Q)1}" | bat --plain --language=help

        # Prevent the original command from executing
        return 1
    fi
}
