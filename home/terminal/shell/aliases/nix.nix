let
  collectGarbage = "sudo nix-collect-garbage -d && sudo nix-store --gc && nix-collect-garbage -d && nix-store --gc";
in {
  "cdnix" = "cd ~/nixos-config";
  "hms" = "nix run home-manager/master -- switch --flake ";
  "ncg" = collectGarbage;
  "ngc" = collectGarbage;
  "nrbs" = "sudo nixos-rebuild switch --flake .#$HOST";
  "nrepl" = "nix repl ~/nixos-config/nixos/system/repl.nix";
}
