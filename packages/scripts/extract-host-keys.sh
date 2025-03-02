if [ -z "$1" ]; then
    echo "Usage: $0 <hostname> [<path>]"
    exit 1
fi


HOST=$1
KEY_PATH=/etc/ssh
if [ -n "$2" ]; then 
	KEY_PATH=$2
fi

sops -d --extract '["ssh_host_ed25519_key"]' "nixos/hosts/$HOST/secrets.yaml" > "$KEY_PATH/ssh_host_ed25519_key"
sops -d --extract '["ssh_host_ed25519_key.pub"]' "nixos/hosts/$HOST/secrets.yaml" > "$KEY_PATH/ssh_host_ed25519_key.pub"
sops -d --extract '["ssh_host_rsa_key"]' "nixos/hosts/$HOST/secrets.yaml" > "$KEY_PATH/ssh_host_rsa_key"
sops -d --extract '["ssh_host_rsa_key.pub"]' "nixos/hosts/$HOST/secrets.yaml" > "$KEY_PATH/ssh_host_rsa_key.pub"

chmod 600 "$KEY_PATH/ssh_host_ed25519_key" "$KEY_PATH/ssh_host_rsa_key"
chmod 644 "$KEY_PATH/ssh_host_ed25519_key.pub" "$KEY_PATH/ssh_host_rsa_key.pub"
