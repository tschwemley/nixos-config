{
  "cdnix" = "cd ~/nixos-config";
  "hms" = "nix run home-manager/master -- switch --flake ";
  "nrbs" = "sudo nixos-rebuild switch --flake .#$HOST";
  "nrepl" = "nix repl ~/nixos-config/nixos/system/repl.nix";
}
