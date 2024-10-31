{
  imports = [
    ../../profiles/proxmox.nix

    # server imports
    ../../../containers/it-tools

    ../../server/alt-frontends/binternet.nix
    ../../server/alt-frontends/priviblur
    ../../server/alt-frontends/safetwitch
    ../../server/knowledge/tiddlywiki.nix
  ];

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
