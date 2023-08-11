#!/bin/sh
ssh_dir="$HOME/.ssh"
secrets_dir="$HOME/nixos-config/nixos/hosts/charizard/secrets.yaml"
sops -d --extract '["ssh_config"]'  $secrets_dir > "$ssh_dir/config"
sops -d --extract '["gh_ssh_key"]' $secrets_dir > "$ssh_dir/github"
sops -d --extract '["mac_ssh_key"]' $secrets_dir > "$ssh_dir/mac"
