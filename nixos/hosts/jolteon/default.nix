let
  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).proxmox;
  profile = import ../../profiles/proxmox.nix;
  server = [
    ../../../containers/jellyfin
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

  networking.hostName = "jolteon";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
