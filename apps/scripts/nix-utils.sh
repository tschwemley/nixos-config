printHelp() {
	echo "Usage: nix-utils [command] (args...)"
	exit 1
}

extractSshDir() {
	secretsPath=./nixos/hosts/$HOST/secrets.yaml
	[[ "$2" == "pc" ]] && \
		sops -d --extract '["ssh_config"]' $secrets > $HOME/.ssh/config && \
		sops -d --extract '["gh_ssh_key"]' $secrets > $HOME/.ssh/personal-gh && \
		sops -d --extract '["mac_ssh_key"]' $secrets > $HOME/.ssh/personal-gh
}

extractSshHostKeys() {
	secretsPath=./nixos/hosts/$2/secrets.yaml
	extractPath=${3:"/persist/etc/ssh"}
	keys_to_extract='["ssh_host_ed25519_key" "ssh_host_ed25519_key_pub" "ssh_host_rsa_key" "ssh_host_rsa_key_pub"]'
	echo "Extracting and dumping ssh host keys"
	sops -d --extract '["ssh_host_ed25519_key.pub"]' $secretsPath > "$extractPath/ssh_host_ed25519_key.pub"
	sops -d --extract '["ssh_host_ed25519_key"]' $secretsPath > "$extractPath/ssh_host_ed25519_key"
	sops -d --extract '["ssh_host_rsa_key.pub"]' $secretsPath > "$extractPath/ssh_host_rsa_key.pub"
	sops -d --extract '["ssh_host_rsa_key"]' $secretsPath > "$extractPath/ssh_host_rsa_key"
}

extractWireguardPrivateKey() {
	if [ -n "$2" ]
	then
		path="$2"
	else
		path="/persist/wireguard/private"
	fi
	secretsPath=./nixos/hosts/$1/secrets.yaml
	sops -d --extract '["wireguard_private"]' $secretsPath > $path 
}

initializeDisk () {
	echo $#
	[ $# -ne 2 ] && echo "arg count"
	nix run --experimental-features 'nix-command flakes' github:nix-community/disko -- -m disko --arg diskName '"$2"' nixos/modules/hardware/disks/$1.nix
}

[ $# -lt 1 ] && printHelp

case $1 in
	"extract-host-keys")
		extractSshHostKeys
		;;

	"extract-ssh-keys" | "extract-ssh")
		extractSshDir $2
		;;

	"extract-wg-private" | "extract-wg")
		extractWireguardPrivateKey $2
		;;

	"init-disk" | "initialize-disk")
		initializeDisk $2 $3
		;;
esac

