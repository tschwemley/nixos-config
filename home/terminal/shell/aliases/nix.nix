lib: {
  cdnix = "cd ~/nixos-config";
  hms = "nix run home-manager/master -- switch --flake ";
  nfc = "nix flake check";
  nfu = "nix flake update && git add flake.lock && git commit -m 'flake update' && git push origin main";
  ngc = "sudo nix-collect-garbage && sudo nix-store --gc --delete-older-than 3d";
  nixconf = "cd ~/nixos-config";
  nrbs = "sudo nixos-rebuild switch --flake .#$HOST";
  systemd2nix = "nix run github:DavHau/systemd2nix";
}
