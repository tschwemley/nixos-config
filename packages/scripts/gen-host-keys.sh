# Check if a filename was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

HOST=$1

ssh-keygen -t ed25519 -f ./ssh_host_ed25519_key -q -N ""
ssh-keygen -t rsa -b 4096 -f ./ssh_host_rsa_key -q -N ""

privateAge=$(ssh-to-age -i ssh_host_ed25519_key -private-key)
publicAge=$(ssh-to-age -i ssh_host_ed25519_key.pub)

cat <<EOL >> ~/.config/sops/age/keys.txt

# $HOST ed25519 host key
# public key: $publicAge
$privateAge
EOL

SOPS_FILE="./nixos/hosts/$1/secrets.yaml"
if [ ! -f "$SOPS_FILE" ]; then
	echo "Sops file doesn't exist. Creating one: $SOPS_FILE"
	echo "{}" > "$SOPS_FILE"
	sops --config .sops.yaml --add-age "$publicAge" --in-place --input-type yaml --output-type yaml -e "$SOPS_FILE"
fi

sops set nixos/hosts/pikachu/secrets.yaml '["ssh_host_ed25519_key.pub"]' "$(jq -R -s . < ./ssh_host_ed25519_key)"
sops set nixos/hosts/pikachu/secrets.yaml '["ssh_host_ed25519_key"]' "$(jq -R -s . < ./ssh_host_ed25519_key)"
sops set nixos/hosts/pikachu/secrets.yaml '["ssh_host_rsa_key.pub"]' "$(jq -R -s . < ./ssh_host_rsa_key)"
sops set nixos/hosts/pikachu/secrets.yaml '["ssh_host_rsa_key"]' "$(jq -R -s . < ./ssh_host_rsa_key)"

rm ssh_host_ed25519_key ssh_host_ed25519_key.pub ssh_host_rsa_key ssh_host_rsa_key.pub

echo "Successfully added ssh host keys to sops file for $HOST and generated age keys"
echo "$HOST public age key: $publicAge"
