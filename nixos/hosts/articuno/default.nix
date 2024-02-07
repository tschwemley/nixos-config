{
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/vda";
  nodeIP = "10.0.0.1";
  nodeName = "articuno";
  role = "server";

  boot = (import ../../system/boot.nix).grub diskName;
  disk = (import ../../hardware/disks).buyvm;
  k3s = import ../../services/k3s {inherit config lib pkgs nodeIP nodeName role;};
  # netmaker = import ../../services/netmaker {inherit lib pkgs;};
  services = [
    ../../network/wireguard.nix
    ../../services/netmaker
    ../../services/caddy
  ];
  profile = import ../../profiles/server.nix;
  wireguard = import ../../network/wireguard.nix {
    inherit config pkgs;
    ip = nodeIP;
    peers = [
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
      {
        #eevee
        AllowedIPs = ["10.0.0.4/32"];
        PersistentKeepalive = 25;
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
      }
      {
        #flareon
        AllowedIPs = ["10.0.0.5/32"];
        PersistentKeepalive = 25;
        PublicKey = "3g+cRzwGUcm+0N/WQlPgBYDcq/IQaA/N2UqMyNn1QWw=";
      }
      {
        # jolteon
        AllowedIPs = ["10.0.0.6/32"];
        PersistentKeepalive = 25;
        PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
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
  imports =
    [
      boot
      disk
      k3s
      profile
      wireguard
      ../../services/k3s/postgresql.nix
    ]
    ++ services;

  environment.systemPackages = with pkgs; [k9s];
  # networking.dhcpcd.enable = false;

  networking = {
    domain = "10.0.0.1";
    hostName = "articuno";
  };

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
