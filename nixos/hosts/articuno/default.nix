{
  config,
  lib,
  pkgs,
  ...
}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  # k3s = import ../../services/k3s {inherit config lib pkgs nodeIP nodeName role;};
  # netmaker = import ../../services/netmaker {inherit lib pkgs;};
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
      # k3s
      profile
      # wireguard
      ../../services/k3s/postgresql.nix
    ]
    ++ services;

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
  environment.systemPackages = with pkgs; [k9s];

  networking = {
    defaultDevice = "ens3";
    hostName = "articuno";
    ipv4 = {
      address = "198.98.62.194/24";
      gateway = "198.98.62.1";
    };
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
    secrets = {
      public_ip = {};
    };
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
