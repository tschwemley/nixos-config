{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "flareon";
  nodeIP = "10.0.0.5";

  boot = import ../../modules/system/systemd-boot.nix;
  disk = import ../../modules/hardware/disks/vm.nix {inherit diskName;};
  k3s = import ../../modules/services/k3s {inherit config lib pkgs nodeIP nodeName;};
  profile = import ../../profiles/server.nix;
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = nodeIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.2/32" "10.0.0.3/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      }
      {
        # zapados
        AllowedIPs = ["10.0.0.2/32"];
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      }
      {
        # moltres
        AllowedIPs = ["10.0.0.3/32"];
        PublicKey = "reQIKAlaJvkqkASpM0xxntIcoB8S5ImXw500m1sRs0Q=";
      }
    ];
  };
in {
  imports = [
    boot
    disk
    k3s
    profile
    wireguard
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd"];
    supportedFilesystems = ["btrfs"];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  systemd.network.enable = true;
  services.resolved.enable = true;

  # don't update this
  system.stateVersion = "23.05";
}
