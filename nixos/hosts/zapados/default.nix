{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  diskName = "/dev/sda";
  hostName = "zapados";
  wireguardIP = "10.0.0.2";
  
  disk = import ../../modules/hardware/disks/k3s.nix { inherit diskName; };
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib pkgs;
    enableImpermanence = false;
    nodeIP = wireguardIP;
    role = "server";
  };
  proxmox = import ../../profiles/proxmox.nix {
    inherit config modulesPath;
  };
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # articuno
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
        AllowedIPs = ["10.0.0.1/32"];
      }
      {
        # moltres
        PublicKey = "";
        AllowedIPs = ["10.0.0.3/32"];
      }
      {
        #eevee
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
        AllowedIPs = ["10.0.0.4/32"];
      }
    ];
  };
in {
  imports = [
	disk
    k3s
    proxmox
    user
    wireguard
  ];
  
  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd" "wireguard"];
    supportedFilesystems = ["btrfs"];
    loader.systemd-boot = {
      enable = true;
      editor = false; # leaving true allows for root access to be gained via passing kernal param
    };
  };

  networking.hostName = hostName;

  # TODO: change this for all hosts soon
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.05";
  systemd.network.enable = true;
  services.resolved.enable = true;
}
