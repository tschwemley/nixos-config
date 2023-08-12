printHelp() {
	echo "Usage: nix-utils [command] (args...)"
	exit 1
}

extractSshHostKeys() {
	secretsPath=./nixos/hosts/$2/secrets.yaml
	keys_to_extract='["ssh_host_ed25519_key" "ssh_host_ed25519_key_pub" "ssh_host_rsa_key" "ssh_host_rsa_key_pub"]'
	echo "Extracting and dumping ssh host keys"
	sops -d --extract '["ssh_host_ed25519_key.pub"]' $secretsPath > /persist/etc/ssh/ssh_host_ed25519_key.pub
	sops -d --extract '["ssh_host_ed25519_key"]' $secretsPath > /persist/etc/ssh/ssh_host_ed25519_key
	sops -d --extract '["ssh_host_ed25519_key.pub"]' $secretsPath > /persist/etc/ssh/ssh_host_ed25519_key.pub
	sops -d --extract '["ssh_host_ed25519_key"]' $secretsPath > /persist/etc/ssh/ssh_host_ed25519_key
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

[ $# -lt 1 ] && printHelp

if [[ "$1" == "extract-host-keys" ]]
then
	[ $# -lt 2 ] || [ ! -f nixos/hosts/$2/secrets.yaml ] && echo "Incorrect number of args or file does not exist" && printHelp
	extractSshHostKeys
elif [[ "$1" == "extract-wg-private" ]]
then
	[ $# -lt 2 ] || [ ! -f nixos/hosts/$2/secrets.yaml ] && echo "Incorrect number of args or file does not exist" && printHelp
	extractWireguardPrivateKey $2
else
	printHelp
fi

