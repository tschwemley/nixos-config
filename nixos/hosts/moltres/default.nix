{
  imports = [
    (import ../../profiles/buyvm.nix "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-25377")

    # server imports
    ../../../containers/freetar
    ../../../containers/searxng
    ../../server/cockroachdb
    ../../server/redlib
    ../../server/rimgo
  ];

  networking.hostName = "moltres";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
