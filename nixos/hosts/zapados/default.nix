{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "zapados";
  role = "server";
  nodeIP = "10.0.0.2";

  boot = import ../../modules/system/systemd-boot.nix;
  disk = import ../../modules/hardware/disks/vm.nix {inherit diskName;};
  k3s = import ../../modules/services/k3s {inherit config lib pkgs nodeIP nodeName role;};
  profile = import ../../profiles/server.nix;
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = nodeIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.3/32" "10.0.0.4/32" "10.0.0.5/32" "10.0.0.6/32" "10.0.0.90/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
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
  imports = [
    boot
    disk
    k3s
    profile
    wireguard
    ../../modules/system/systemd-boot.nix
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # don't update this
  system.stateVersion = "23.05";
}
