printHelp() {
	echo "Usage: nix-utils [command] (args...)"
	exit 1
}

dumpKeys() {
	secretsPath=./nixos/hosts/$2/secrets.yaml
	keys_to_extract='["ssh_host_ed25519_key" "ssh_host_ed25519_key_pub" "ssh_host_rsa_key" "ssh_host_rsa_key_pub"]'
	echo "sops -d --extract $keys_to_extract $secretsPath\n\n"
	sops -d --extract $keys_to_extract $secretsPath
}

[ $# -lt 1 ] && printHelp

if [[ $1 -eq "dump-host-keys" ]]
then
	[ $# -lt 2 ] || [ ! -f nixos/hosts/$2/secrets.yaml ] && echo "Incorrect number of args or file does not exist" && printHelp
	dumpKeys
else
	printHelp
fi

