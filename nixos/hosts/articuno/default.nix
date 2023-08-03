{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  nodeName = "articuno";
  wireguardIP = "10.0.0.1";

  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib nodeName pkgs;
    clusterInit = true;
    nodeIP = wireguardIP;
    role = "server";
  };
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = nodeName;
  };
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # zapados
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
        AllowedIPs = ["10.0.0.2/32"];
      }
      {
        # moltres
        PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
        AllowedIPs = ["10.0.0.3/32"];
      }
      {
        #eevee
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
        AllowedIPs = ["10.0.0.4/32"];
      }
      {
        #machamp
        PublicKey = "Mm+2LeQCIxh1Rc89tCErB2G4v8QB1aXMTf9VTT1+52w=";
        AllowedIPs = ["10.0.0.99/32"];
      }
    ];
  };
in {
  imports = [
    k3s
    user
    wireguard
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

  networking.dhcpcd.enable = false;
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

  users = {
    mutableUsers = false;
    users = {
      root = {
        passwordFile = config.sops.secrets.root_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
      ${nodeName} = {
        passwordFile = config.sops.secrets.user_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ./ssh_key.pub)];
      };
    };
  };
}
