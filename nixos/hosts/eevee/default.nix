{
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/vda";
  nodeName = "eevee";
  nodeIP = "10.0.0.4";

  boot = (import ../../system/boot.nix).boot diskName;
  disk = (import ../../hardware/disks).buyvmWithStorage;
  k3s = import ../../services/k3s {inherit config lib pkgs nodeIP nodeName;};
  profile = import ../../profiles/server.nix;
  syncthing = import ../../services/syncthing.nix {
    inherit lib pkgs;
    enableDiscovery = true;
  };
  wireguard = import ../../network/wireguard.nix {
    inherit config;
    ip = nodeIP;
    peers = [
      {
        # articuno
        AllowedIPs = ["10.0.0.1/32" "10.0.0.2/32" "10.0.0.3/32" "10.0.0.5/32" "10.0.0.6/32"];
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

  # eevee has issues with DHCP so disable and use systemd-networkd instead
  networking = {
    dhcpcd.enable = false;
    hostName = nodeName;
    firewall.allowedTCPPorts = [51413];
    firewall.allowedUDPPorts = [51413];
  };

  # TODO: change this on all servers
  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/root/.config/sops/age/keys.txt";

    # Specify machine secrets
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
