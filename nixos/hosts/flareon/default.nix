{inputs, ...}: {
  imports = [
    inputs.stash.nixosModules.default
    # extra storage partition
    (import ../../hardware/disks/block-storage.nix {
      storageName = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";
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
    servarr.enableWhisparr = true;
    tailscale.extraUpFlags = [
      "--exit-node=us-chi-wg-007-1.mullvad.ts.net"
      "--exit-node-allow-lan-access=true"
    ];
  };
}
