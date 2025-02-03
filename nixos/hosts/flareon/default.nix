{
  inputs,
  lib,
  ...
}: let
  # two extra storage drives on flareon host TODO: move this to someplace generic
  numExtraDrives = 2;
  extraDrives = builtins.genList (i: let
    iStr = builtins.toString (i + 2);
  in
    import ../../hardware/disks/block-storage.nix {
      device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi${iStr}";
      mountpoint = "storage${iStr}";
    })
  numExtraDrives;
in {
  imports =
    [
      inputs.stash.nixosModules.default

      # extra storage drives
      # (import ../../hardware/disks/block-storage.nix {
      #   device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi2";
      #   mountpoint = "storage2";
      # })
      # (import ../../hardware/disks/block-storage.nix {
      #   device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi3";
      #   mountpoint = "storage3";
      # })

      ../../profiles/proxmox.nix
      ../../services/samba.nix
    ]
    ++ extraDrives;

  networking.hostName = "flareon";

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
