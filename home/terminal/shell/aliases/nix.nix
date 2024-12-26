let
  collectGarbage = "sudo nix-collect-garbage -d && sudo nix-store --gc && nix-collect-garbage -d && nix-store --gc";
in {
  cdnix = "cd ~/nixos-config";
  hms = "nix run home-manager/master -- switch --flake ";
  ncg = collectGarbage;
  nfc = "nix flake check";
  nfu = "nix flake update && git add flake.lock && git commit -m 'flake update' && git push origin main";
  ngc = collectGarbage;
  nixconf = "cd ~/nixos-config";
  nrbs = "sudo nixos-rebuild switch --flake .#$HOST";
  nrepl = "cd ~/nixos-config && nix repl -f ./nixos/system/repl.nix && cd -";
}
