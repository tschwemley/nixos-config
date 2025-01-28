{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.stash.nixosModules.default

    # extra storage partition
    (import ../../hardware/disks/block-storage.nix {
      device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi2";
      mountpoint = "storage2";
    })

    ../../profiles/proxmox.nix
    ../../services/samba.nix
  ];

  networking.hostName = "flareon";

  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";

  services = {
    rclone = {
      enableJolteon = true;
      enableZapados = true;
    };

    # TODO: remove this after refactoring sabnzbd config/module
    sabnzbd.enable = lib.mkDefault false;

    # TODO: reenable after fixing port collision
    # servarr.enableWhisparr = true;
    tailscale.extraUpFlags = [
      "--exit-node=us-chi-wg-301-1.mullvad.ts.net"
      "--exit-node-allow-lan-access=true"
    ];
  };
}
