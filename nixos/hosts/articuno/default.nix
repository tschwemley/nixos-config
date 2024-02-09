{
  config,
  lib,
  pkgs,
  ...
}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  services = [
    ../../network/wireguard.nix
    ../../services/caddy
  ];
  profile = import ../../profiles/server.nix;
in {
  imports =
    [
      boot
      disk
      profile
      ../../services/k3s/postgresql.nix
    ]
    ++ services;

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
  environment.systemPackages = with pkgs; [k9s];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
