# Check if a filename was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

HOST=$1

tmp=$(mktemp -d)

ssh-keygen -t ed25519 -f "$tmp/ssh_host_ed25519_key" -q -N ""
ssh-keygen -t rsa -b 4096 -f "$tmp/ssh_host_rsa_key" -q -N ""
# ssh-keygen -t ed25519 -f "$tmp/user_ssh_key" -q -N ""

privateAge=$(ssh-to-age -i "$tmp/ssh_host_ed25519_key" -private-key)
publicAge=$(ssh-to-age -i "$tmp/ssh_host_ed25519_key.pub")

echo "publicSSH:"
cat "$tmp/ssh_host_ed25519_key.pub"
echo "privateSSH:"
cat "$tmp/ssh_host_ed25519_key"
echo "publicAge:"
echo "$publicAge"
echo "$privateAge"

# cat <<EOL >> ~/.config/sops/age/keys.txt
#
# # $HOST ed25519 host key
# # public key: $publicAge
# $privateAge
# EOL
#
# SOPS_FILE="./nixos/hosts/$1/secrets.yaml"
# if [ ! -f "$SOPS_FILE" ]; then
# 	echo "Sops file doesn't exist. Creating one: $SOPS_FILE"
# 	echo "{}" > "$SOPS_FILE"
# 	sops --config .sops.yaml --add-age "$publicAge" --in-place --input-type yaml --output-type yaml -e "$SOPS_FILE"
# fi
#
# sops set "nixos/hosts/$HOST/secrets.yaml" '["ssh_host_ed25519_key.pub"]' "$(jq -R -s . < ./ssh_host_ed25519_key)"
# sops set "nixos/hosts/$HOST/secrets.yaml" '["ssh_host_ed25519_key"]' "$(jq -R -s . < ./ssh_host_ed25519_key)"
# sops set "nixos/hosts/$HOST/secrets.yaml" '["ssh_host_rsa_key.pub"]' "$(jq -R -s . < ./ssh_host_rsa_key)"
# sops set "nixos/hosts/$HOST/secrets.yaml" '["ssh_host_rsa_key"]' "$(jq -R -s . < ./ssh_host_rsa_key)"
# sops set "nixos/hosts/$HOST/secrets.yaml" '["user_ssh_key"]' "$(jq -R -s . < ./user_ssh_key)"
#
# mv user_ssh_key.pub "../../nixos/hosts/$HOST/ssh_key.pub"
# rm ssh_host_ed25519_key ssh_host_ed25519_key.pub ssh_host_rsa_key ssh_host_rsa_key.pub user_ssh_key
#
# echo "Successfully added ssh host keys to sops file for $HOST and generated age keys"
# echo "$HOST public age key: $publicAge"

# clean up tmp dir
rm -rf "$tmp"
