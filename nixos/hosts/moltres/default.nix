let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  profile = (import ../../profiles/buyvm.nix "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-25377");
  server = [
    ../../../containers/searxng
    ../../server/cockroachdb
    ../../server/redlib
  ];
in {
  imports =
    [
      boot
      profile
    ]
    ++ server;

  networking.hostName = "moltres";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
