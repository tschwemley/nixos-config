#!/run/current-system/sw/bin/bash

SCRIPT_PATH=$(readlink -f "$0")                                               
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

host=$1

[ -z "$host" ] || [ ! -d "$SCRIPT_DIR/../nixos/hosts/$host" ] && echo "Incorrect or missing host" && exit

# use second arg as target host if passed; otherwise fallback to using $host
targetHost=$([ $# -eq 2 ] && echo "$2" || echo "$host")

# create tmp dir for storing host files (mirroring host's root file structure)
hostDir=$(mktemp -d)
mkdir -p "$hostDir"/etc/{sops,ssh}

# cd to the flake root to match sops creation rule
cd "$SCRIPT_DIR/.." || exit

# decrypt the ssh_host keys and put them into the host's dir
for key in ssh_host_{ed25519,rsa}_key{,.pub}; do
	sops -d --extract "[\"$key\"]" ./nixos/hosts/"$host"/secrets.yaml > "$hostDir"/etc/ssh/"$key"
done

# decrypt and create the host age key file
sops -d --extract '["age_secret_key"]' ./nixos/hosts/"$host"/secrets.yaml > "$hostDir"/etc/sops/age-keys.txt

# fix perms for priv keys. everything else defaults to 644, which is fine
chmod 600 "$hostDir"/etc/ssh/ssh_host_{rsa,ed25519}_key

echo "created host files in: $hostDir"

echo "beginning remote install...\n\n"
echo nix run github:nix-community/nixos-anywhere -- \
	--flake ".#$host" \
	--extra-files "$hostDir" \
 	--ssh-option "IdentityFile=~/.ssh/$host" \
	--target-host "$targetHost"

#  SSHPASS=ueY9dW1e1271QMIxyY nix run github:nix-community/nixos-anywhere -- --flake .#moltres --extra-files /tmp/tmp.qiVTFd6YSN --ssh-option IdentityFile=~/.ssh/moltres --target-host root@192.227.209.134
