{inputs, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvmWithStorage;
  # disk = (import ../../hardware/disks).buyvm;
  profile = import ../../profiles/buyvm.nix;
  server = [
#"${inputs.nix-private.outPath}/containers/invidious"
    ../../../containers/searxng
    ../../server/cockroachdb
    ../../server/redlib
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
