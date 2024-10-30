{
  imports = [
    ../../profiles/proxmox.nix

    # server imports
    ../../../containers/binternet
    ../../../containers/it-tools
    ../../../containers/priviblur
    ../../../containers/safetwitch

    ../../server/knowledge/tiddlywiki.nix
  ];

  environment.sessionVariables.TERM = "kitty";

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
