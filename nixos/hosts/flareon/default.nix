{inputs, ...}: {
  imports = [
    inputs.stash.nixosModules.default
    # extra storage partition
    (import ../../hardware/disks/block-storage.nix "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi2" "/storage2")

    ../../profiles/proxmox.nix
    # ../../server/arr/whisparr.nix
    ../../services/samba.nix
  ];

  networking.hostName = "flareon";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";

  services.tailscale.extraUpFlags = [
    "--exit-node=us-chi-wg-007-1.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
  ];
}
