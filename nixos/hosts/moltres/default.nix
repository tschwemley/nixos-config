{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "moltres";
  wireguardIP = "10.0.0.3";

  k3s = import ../../profiles/k3s.nix {
    inherit inputs config diskName lib nodeName pkgs;
    enableImpermanence = false;
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
        # articuno
        AllowedIPs = ["10.0.0.1/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      }
      {
        # zapados
        AllowedIPs = ["10.0.0.2/32"];
        Gateway = "10.0.0.1";
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      }
      {
        #eevee
        AllowedIPs = ["10.0.0.4/32"];
        Gateway = "10.0.0.1";
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
      }
    ];
  };
in {
  imports = [
    k3s
    user
    wireguard
  ];

  boot.loader.systemd-boot = {
    enable = true;
    editor = false; # leaving true allows for root access to be gained via passing kernal param
  };

  # TODO: might be needed for proxmox to configure networking
  #services.cloud-init.network.enable = true;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";
  };

  # TODO: change this for all hosts soon
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.05";
}
