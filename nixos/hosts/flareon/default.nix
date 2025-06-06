{inputs, ...}: let
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
      inputs.nix-private.nixosModules.envs.flareon

      ../../profiles/proxmox.nix
      ../../services/samba.nix

      #TODO: clean this up + clean up extraDrives
      (import ../../hardware/disks/block-storage.nix {
        device = "/dev/disk/by-id/ata-WDC_WD80EDAZ-11CEWB0_WD-RD0D74JE";
        mountpoint = "storage4";
      })
    ]
    ++ extraDrives;

  networking.hostName = "flareon";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";

  services = {
    # TODO: remove this after refactoring rclone imports (or making explicit module)
    # rclone.enableJolteon = true;

    tailscale.extraSetFlags = [
      "--exit-node-allow-lan-access=true"
      "--exit-node=us-chi-wg-307.mullvad.ts.net"
    ];
  };
}
