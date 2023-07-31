{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  hostName = "zapados";
  wireguardIP = "10.0.0.2";

  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib pkgs;
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
      { # articuno
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
        AllowedIPs = ["10.0.0.1/32"];
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
    k3s
    proxmox
    user
    wireguard
  ];

  networking.hostName = hostName;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";
  };

  # TODO: change this for all hosts soon
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.05";
  systemd.network.enable = true;
  services.resolved.enable = true;
}
