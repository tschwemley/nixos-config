{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/vda";
  nodeIP = "10.0.0.3";
  nodeName = "moltres";
  useGrub = true;

  boot = import ../../modules/system/grub-boot.nix {inherit diskName;};
  disk = import ../../modules/hardware/disks/vm.nix {inherit diskName useGrub;};
  k3s = import ../../modules/services/k3s {
    inherit config lib pkgs nodeIP nodeName;
    role = "server";
  };
  profile = import ../../profiles/server.nix;
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = nodeIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.2/32" "10.0.0.4/32" "10.0.0.5/32" "10.0.0.90/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      }
      {
        # zapados
        AllowedIPs = ["10.0.0.2/32"];
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      }
      {
        #eevee
        AllowedIPs = ["10.0.0.4/32"];
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
      }
      {
        #flareon
        AllowedIPs = ["10.0.0.5/32"];
        PersistentKeepalive = 25;
        PublicKey = "3g+cRzwGUcm+0N/WQlPgBYDcq/IQaA/N2UqMyNn1QWw=";
      }
      {
        #machamp
        AllowedIPs = ["10.0.0.90/32"];
        PersistentKeepalive = 25;
        PublicKey = "tetndLcx82SrEVzR0hjoqASdQPEjdb5nZHXizL82vUI=";
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

  fileSystems."/storage" = {
    device = "/dev/sda1";
    fsType = "btrfs";
    neededForBoot = true;
    options = ["compress=lzo"];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";

    secrets = {
      systemd_networkd_10_ens3 = {
        mode = "0444";
        path = "/etc/systemd/network/10-ens3.network";
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  # don't update this
  system.stateVersion = "23.05";
}
