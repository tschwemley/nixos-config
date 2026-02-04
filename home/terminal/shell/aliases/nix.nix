{
  cdnix = "cd ~/nixos-config";
  hms = "nix run home-manager/master -- switch --flake ";
  nfc = "nix flake check";
  ngc = "sudo nix-collect-garbage --delete-older-than 3d";
  nixconf = "cd ~/nixos-config";
  nrbs = "sudo nixos-rebuild switch --flake .#$HOST |& nom";
  systemd2nix = "nix run github:DavHau/systemd2nix";
}
