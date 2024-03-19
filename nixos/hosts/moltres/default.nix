let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvmWithStorage;
  profile = import ../../profiles/buyvm.nix;
  server = [
    ../../containers/redlib
    ../../containers/searxng
    ../../server/cockroachdb
    (import ../../services/seaweedfs {
      dataCenter = "miami";
      rack = "moltres";
      # withMaster = true;
      # withFiler = true;
    })
  ];
in {
  imports =
    [
      boot
      disk
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
