let
  boot = (import ../../system/boot.nix).systemd;
  profile = import ../../profiles/proxmox.nix;
  server = [];
in {
  imports =
    [
      boot
      profile
    ]
    ++ server;

  networking.hostName = "jolteon";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
