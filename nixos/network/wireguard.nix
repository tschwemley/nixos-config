{
  config,
  lib,
  pkgs,
  ...
}: let
  ListenPort = 51820;

  wgHostInfo = {
    articuno = rec {
      ip = "10.0.0.1";
      networkConfig = {
        IPForward = true;
        IPMasquerade = "ipv4";
        # IPv6AcceptRA = false;
      };
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/29"];
        Endpoint = "articuno.schwem.io:${toString ListenPort}";
        PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
      };
    };
    zapados = rec {
      ip = "10.0.0.2";
      # networkConfig = {
      #   IPv6AcceptRA = false;
      # };
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
      };
    };
    moltres = rec {
      ip = "10.0.0.3";
      networkConfig = {
        IPForward = true;
        IPMasquerade = "ipv4";
        IPv6AcceptRA = false;
      };
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/29"];
        # AllowedIPs = ["${ip}/32" "10.0.0.1/32" "10.0.0.2/32" "10.0.0.4/32" "10.0.0.5/32" "10.0.0.6/32"];
        Endpoint = "moltres.schwem.io:${toString ListenPort}";
        PublicKey = "reQIKAlaJvkqkASpM0xxntIcoB8S5ImXw500m1sRs0Q=";
      };
    };
    eevee = rec {
      # inherit dns;
      ip = "10.0.0.4";
      # networkConfig = {
      #   IPv6AcceptRA = false;
      # };
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
      };
    };
    flareon = rec {
      # inherit dns;
      ip = "10.0.0.5";
      # networkConfig = {
      #   IPv6AcceptRA = false;
      # };
      wireguardPeerConfig = {
        AllowedIPs = ["${ip}/32"];
        PersistentKeepalive = 25;
        PublicKey = "3g+cRzwGUcm+0N/WQlPgBYDcq/IQaA/N2UqMyNn1QWw=";
      };
    };
    jolteon = rec {
      # inherit dns;
      ip = "10.0.0.6";
      # networkConfig = {
      #   IPv6AcceptRA = false;
      # };
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
  hostName = config.networking.hostName;
  host = wgHostInfo.${hostName};
  wireguardPeers = pkgs.lib.mapAttrsToList (_: value: {
    inherit (value) wireguardPeerConfig;
  }) (removeAttrs wgHostInfo [hostName]);
in {
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.firewall.allowedUDPPorts = [ListenPort];

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

    networks."20-wg0" = {
      address = [
        "10.0.0.0/29"
      ];
      # dns = lib.mkIf (host ? dns) host.dns;
      DHCP = "no";
      name = "wg0";
      networkConfig = lib.mkIf (host ? networkConfig) host.networkConfig;
      # routeConfig.gateway = lib.mkIf (hostName == "articuno" && hostName != "moltres") ["10.0.0.1" "10.0.0.3"];
    };
  };
}
