{
  imports = [
    # ../../profiles/proxmox.nix
    # ../../services/samba.nix
  ];

  networking.hostName = "tentacool";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
