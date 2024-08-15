if [ $# -ne 1 ]; then 
	echo "usage: prefetch.sh <url_to_prefetch>"
	exit 1
fi

TYPE=sha256
URL=$1

nix hash to-sri --type $TYPE "$(nix-prefetch-url --type $TYPE "$URL")"

# https://github.com/redlib-org/redlib/releases/download/v0.35.1/redlib
