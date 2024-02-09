{
  config,
  lib,
  pkgs,
  ...
}: let
  ListenPort = 51820;
  # dns = ["10.0.0.1" "10.0.0.3"];
  dns = ["10.0.0.1"];

  wgHostInfo = {
    articuno = rec {
      ip = "10.0.0.1";
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32" "10.0.0.2/32" "10.0.0.3/32" "10.0.0.4/32" "10.0.0.5/32" "10.0.0.6/32"];
        Endpoint = "articuno.schwem.io:${toString ListenPort}";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      };
    };
    zapados = rec {
      inherit dns;
      ip = "10.0.0.2";
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      };
    };
    moltres = rec {
      ip = "10.0.0.3";
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        # AllowedIPs = ["${ip}/32" "10.0.0.1/32" "10.0.0.2/32" "10.0.0.4/32" "10.0.0.5/32" "10.0.0.6/32"];
        Endpoint = "moltres.schwem.io:${toString ListenPort}";
        PublicKey = "reQIKAlaJvkqkASpM0xxntIcoB8S5ImXw500m1sRs0Q=";
      };
    };
    eevee = rec {
      inherit dns;
      ip = "10.0.0.4";
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
      };
    };
    flareon = rec {
      inherit dns;
      ip = "10.0.0.5";
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "3g+cRzwGUcm+0N/WQlPgBYDcq/IQaA/N2UqMyNn1QWw=";
      };
    };
    jolteon = rec {
      inherit dns;
      ip = "10.0.0.6";
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
      };
    };
    # charizard = {
    #   ip = "10.0.0.x";
    #   wireguardPeerConfig = {
    #     address = "10.0.0.x";
    #     pubkey = "xxxxxxxx";
    #   };
    # };
  };
  host = wgHostInfo.${config.networking.hostName};
  wireguardPeers = pkgs.lib.mapAttrsToList (_: value: {
    inherit (value) wireguardPeerConfig;
  }) (removeAttrs wgHostInfo [config.networking.hostName]);
in {
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking = {
    firewall = {
      allowedUDPPorts = [ListenPort];
      # trustedInterfaces = ["wg0"];
    };
  };

  sops.secrets = {
    wireguard_private = {
      mode = "0400";
      path = "/persist/secrets/wireguard-private";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
      restartUnits = ["systemd-networkd" "systemd-resolved"];
    };
  };

  systemd.network = {
    netdevs = {
      "20-wg0" = {
        inherit wireguardPeers;

        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1420";
        };

        wireguardConfig = {
          inherit ListenPort;
          PrivateKeyFile = config.sops.secrets.wireguard_private.path;
        };
      };
    };

    networks = {
      "20-wg0" = {
        name = "wg0";
        # IP addresses the client interface will have
        address = [
          "${host.ip}/24"
        ];
        dns = lib.mkIf (host ? dns) host.dns;
      };
    };
  };
}
