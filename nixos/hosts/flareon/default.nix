let
  mediaUser = (import ../../system/users.nix).media;
in {
  imports = [
    ../../profiles/proxmox.nix
    ../../services/nfs.nix
    ../../services/samba.nix
    mediaUser
  ];

  networking.hostName = "flareon";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
