{config, ...}: {
  "nrbs" = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
}
