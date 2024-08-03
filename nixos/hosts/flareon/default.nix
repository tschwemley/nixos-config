{inputs, lib, ...}: let
  boot = (import ../../system/boot.nix).systemd;
  disk = import ../../hardware/disks/ephemeral-root.nix { diskName = "/dev/sdb"; };
  profile = import ../../profiles/proxmox.nix;
  server = [
    "${inputs.nix-private.outPath}/containers/stash"
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

  networking.hostName = "flareon";
  services.resolved.dnsovertls = lib.mkDefault "true";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
