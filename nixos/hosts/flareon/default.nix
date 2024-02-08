{
  config,
  lib,
  pkgs,
  ...
}: let
  nodeName = "flareon";
  nodeIP = "10.0.0.5";

  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).proxmox;
  k3s = import ../../services/k3s {inherit config lib pkgs nodeIP nodeName;};
  profile = import ../../profiles/server.nix;
  syncthing = import ../../services/syncthing.nix {inherit pkgs;};
  wireguard = import ../../network/wireguard.nix {
    inherit config pkgs;
    ip = nodeIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.2/32" "10.0.0.3/32" "10.0.0.4/32" "10.0.0.6/32"];
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
      {
        #eevee
        AllowedIPs = ["10.0.0.4/32"];
        PersistentKeepalive = 25;
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
      }
      {
        # jolteon
        AllowedIPs = ["10.0.0.6/32"];
        PersistentKeepalive = 25;
        PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
      }
    ];
  };
in {
  imports = [
    boot
    disk
    k3s
    profile
    syncthing
    wireguard
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
