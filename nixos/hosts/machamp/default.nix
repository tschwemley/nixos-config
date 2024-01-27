{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/sda";
  nodeName = "machamp";
  wireguardIP = "10.0.0.90";

  boot = import ../../system/systemd-boot.nix;
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config diskName lib nodeName pkgs;
    enableImpermanence = false;
    nodeIP = wireguardIP;
    role = "agent";
  };
  user = import ../../modules/users/server.nix {inherit config;};
  wireguard = import ../../network/wireguard.nix {
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
  ];

  networking.hostName = nodeName;

  # this fixes a 'restricted url' issue when building host configs
  nix.extraOptions = ''
    allowed-uris = https://git.sr.ht/
  '';

  services.getty.autologinUser = "root";
  services.openssh.enable = true;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # don't update this
  system.stateVersion = "23.05";

  systemd.network.enable = true;
  services.resolved.enable = true;
}
