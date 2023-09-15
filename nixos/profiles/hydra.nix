{inputs, ...}: {
  imports = [
    ./server.nix
    ../modules/services/cloudflared.nix
    ../modules/services/hydra.nix
  ];
}
