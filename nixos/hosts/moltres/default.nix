{
  imports = [
    (import ../../profiles/buyvm.nix "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-25377")

    # server imports
    ../../../containers/excalidraw

    ../../server/alt-frontends/freetar.nix
    ../../server/alt-frontends/redlib.nix
    ../../server/alt-frontends/rimgo.nix
    ../../server/services/searxng

    # ../../../containers/threadfin
  ];

  networking.hostName = "moltres";

  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
