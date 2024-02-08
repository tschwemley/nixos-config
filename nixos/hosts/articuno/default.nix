{
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/vda";

  boot = (import ../../system/boot.nix).grub diskName;
  disk = (import ../../hardware/disks).buyvm;
  # k3s = import ../../services/k3s {inherit config lib pkgs nodeIP nodeName role;};
  # netmaker = import ../../services/netmaker {inherit lib pkgs;};
  services = [
    ../../network/wireguard.nix
    ../../services/netmaker
    ../../services/caddy
  ];
  profile = import ../../profiles/server.nix;
in {
  imports =
    [
      boot
      disk
      # k3s
      profile
      # wireguard
      ../../services/k3s/postgresql.nix
    ]
    ++ services;

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
  environment.systemPackages = with pkgs; [k9s];

  # networking.dhcpcd.enable = false;

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";

    secrets = {
      systemd_networkd_10_ens3 = {
        mode = "0644";
        path = "/etc/systemd/network/10-ens3.network";
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  # don't update this
  system.stateVersion = "23.05";
}
