{...}: {
  imports = [
    ./server.nix
    ./proxmox.nix
    ../modules/services/cloudflared.nix
    ../modules/services/hydra.nix
  ];
}
