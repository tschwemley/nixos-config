let 
  partitions = import ../../hardware/disks/efi-partitions.nix;
  rootDisk = import ../../hardware/disks/ephemeral-root.nix "/dev/sda" partitions;
in {
  imports = [
    rootDisk
    ../../system/boot/systemd.nix
    ../../profiles/server.nix

    # server imports
    ../../server/jellyfin
  ];

  networking = {
    hostName = "tentacool";
    wireless.enable = true;
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
