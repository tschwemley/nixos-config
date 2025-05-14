{
  imports = [
    ../../profiles/proxmox-no-storage.nix

    ../../server/alt-frontends/binternet.nix
    ../../server/alt-frontends/priviblur
    ../../server/alt-frontends/redlib.nix
    ../../server/automation/home-assistant
    ../../server/knowledge/tiddlywiki
    ../../server/services/newsblur
    # ../../server/services/webhooks
    ../../system/fonts.nix
  ];

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
