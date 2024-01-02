{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/vda";
  nodeName = "articuno";
  useGrub = true;
  wireguardIP = "10.0.0.1";

  boot = import ../../modules/system/grub-boot.nix {inherit diskName;};
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib nodeName pkgs useGrub;
    clusterInit = true;
    enableImpermanence = false;
    extraKernelModules = ["kvm-amd"];
    nodeIP = wireguardIP;
    role = "server";
  };
  user = import ../../modules/users/server.nix {inherit config;};
  wireguard = import ../../modules/networking/wireguard.nix {
    inherit config;
    ip = wireguardIP;
    peers = [
      {
        # zapados
        AllowedIPs = ["10.0.0.2/32"];
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      }
      {
        # moltres
        AllowedIPs = ["10.0.0.3/32"];
        PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
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
    k3s
    user
    wireguard
  ];

  networking = {
    dhcpcd.enable = false;
    firewall.allowedTCPPorts = [5432];
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = ["kubernetes"];
    enableTCPIP = true;
    port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #...
      #type database DBuser origin-address auth-method
      # ipv4
      local sameuser  all     peer        map=superuser_map
      host  all      all     127.0.0.1/32   trust
      host  all      all     10.0.0.1/32   trust
      host  all      all     10.0.0.2/32   trust
      host  all      all     10.0.0.3/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';

    identMap = ''
      # ArbitraryMapName systemUser DBUser
         superuser_map      root      postgres
         # superuser_map      postgres  postgres
         # Let other names login as themselves
         # superuser_map      /^(.*)$   \1
    '';

    # initialScript = pkgs.writeText "backend-initScript" ''
    #   CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
    #   CREATE DATABASE nixcloud;
    #   GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    # '';
  };

  services.openssh = {
    enable = true;
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
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
