{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "moltres";
  wireguardIP = "10.0.0.3";

  boot = import ../../modules/system/systemd-boot.nix;
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config diskName lib nodeName pkgs;
    enableImpermanence = false;
    nodeIP = wireguardIP;
    role = "server";
  };
  user = import ../../modules/users/server.nix {inherit config;};
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.3/32" "10.0.0.5/32"];
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
    ];
  };
in {
  imports = [
    boot
    k3s
    user
    wireguard
    ../../modules/system/systemd-boot.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
    editor = false; # leaving true allows for root access to be gained via passing kernal param
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";
  };

  # don't update this
  system.stateVersion = "23.05";
}
