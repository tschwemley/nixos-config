{
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "jolteon";
  wireguardIP = "10.0.0.6";

  boot = import ../../modules/system/systemd-boot.nix;
  k3s = import ../../profiles/k3s.nix {
    inherit config diskName lib nodeName pkgs;
    nodeIP = wireguardIP;
    role = "agent";
  };
  user = import ../../modules/users/server.nix {inherit config;};
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.2/32" "10.0.0.3/32"];
        Endpoint = "wg.schwem.io:9918";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      }
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

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # don't update this
  system.stateVersion = "23.05";
}
