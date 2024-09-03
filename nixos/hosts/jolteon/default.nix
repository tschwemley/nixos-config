{
  imports = [
    ../../profiles/proxmox.nix

    # server
    ../../server/anonymous-overflow
  ];

  networking.hostName = "jolteon";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
