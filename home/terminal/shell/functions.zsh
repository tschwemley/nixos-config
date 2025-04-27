# nix build with output of last error
nbuild() {
  nix build "$@" 2>/tmp/last-build.error.log
  $(tail -n1 /tmp/last-build.error.log | sed "s/.*\(nix log.*\)'./\1/")
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
