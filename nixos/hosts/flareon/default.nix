{
  self,
  pkgs,
  ...
}: let
  # two extra storage drives on flareon host TODO: move this to someplace generic
  numExtraDrives = 3;
  extraDrives =
    builtins.genList (
      i: let
        iStr = builtins.toString (i + 2);
      in
        import ../../hardware/disks/block-storage.nix {
          device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi${iStr}";
          mountpoint = "storage${iStr}";
        }
    )
    numExtraDrives;
in {
  imports =
    [
      self.inputs.nix-private.nixosModules.envs.flareon

      ../../profiles/proxmox.nix
      ../../services/samba.nix
    ]
    ++ extraDrives;

  environment.systemPackages = [pkgs.unrar];

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
