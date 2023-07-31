{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  hostName = "articuno";
  wireguardIP = "10.0.0.1";

  diskConfig = import ../../modules/hardware/disks/k3s.nix {diskName = "/dev/vda";};
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib pkgs;
    clusterInit = true;
    nodeIP = wireguardIP;
    role = "server";
  };
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      { # zapados
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
        AllowedIPs = ["10.0.0.2/32"];
      }
      { # moltres
        
        PublicKey = "uIrOynrMnIpY//v+1WLsTD//swl0Y4J/an0/gllWpz4=";
        AllowedIPs = ["10.0.0.3/32"];
      }
      { #eevee
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
        AllowedIPs = ["10.0.0.4/32"];
      }
    ];
  };
in {
  imports = [
    diskConfig
    k3s
    user
    ./wireguard.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["kvm-amd" "wireguard"];
    supportedFilesystems = ["btrfs"];
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        devices = ["/dev/vda"];
      };
    };
  };

  networking = {
    inherit hostName;
    dhcpcd.enable = false;
  };

  services.getty.autologinUser = "root";

  services.openssh = {
    enable = true;
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";

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
  systemd.network.enable = true;
  services.resolved.enable = true;

  users = {
    mutableUsers = false;
    users = {
      root = {
        passwordFile = config.sops.secrets.root_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
      ${hostName} = {
        passwordFile = config.sops.secrets.user_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
    };
  };
}
