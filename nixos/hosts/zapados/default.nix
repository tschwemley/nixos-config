{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "zapados";
  wireguardIP = "10.0.0.2";

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
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
        AllowedIPs = ["10.0.0.1/32"];
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

  # TODO: change this for all hosts soon
  services.getty.autologinUser = "root";

  # TODO: might be needed for proxmox to configure networking
  #services.cloud-init.network.enable = true;
	
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/persist/.age-keys.txt";
	};

  # don't update this
  system.stateVersion = "23.05";
}
