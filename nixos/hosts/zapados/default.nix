{
  imports = [
    ../../profiles/proxmox.nix

    # server imports
    # ../../server/forgejo
    ../../../containers/binternet
    ../../../containers/it-tools
    ../../../containers/priviblur
    ../../../containers/safetwitch
  ];

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
