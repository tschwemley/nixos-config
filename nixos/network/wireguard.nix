{
  # self,
  config,
  pkgs,
  ...
}: let
  ListenPort = 51820;

  wgHostInfo = {
    articuno = {
      ip = "10.0.0.1";
      AllowedIPs = ["10.0.0.1/32"];
      Endpoint = "articuno.schwem.io:${ListenPort}";
      PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
    };
    # zapados = {
    #   AllowedIPs = ["10.0.0.2/32"];
    #   PublicKey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
    # };
    # moltres = {
    #   AllowedIPs = ["10.0.0.3/32"];
    #   Endpoint = "moltres.schwem.io";
    #   PublicKey = "reQIKAlaJvkqkASpM0xxntIcoB8S5ImXw500m1sRs0Q=";
    # };
    # eevee = {
    #   AllowedIPs = ["10.0.0.4/32"];
    #   PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
    # };
    # flareon = {
    #   AllowedIPs = ["10.0.0.5/32"];
    #   PublicKey = "3g+cRzwGUcm+0N/WQlPgBYDcq/IQaA/N2UqMyNn1QWw=";
    # };
    jolteon = {
      ip = "10.0.0.6";
      AllowedIPs = ["10.0.0.6/32"];
      PublicKey = "FT9Gnx4Ond9RRRvEkVmabRkF6Cjlzaus29Bg8MbIKkk=";
    };
    # charizard = {
    #   address = "10.0.0.xx";
    #   pubkey = "";
    # };
  };
  host = wgHostInfo.${config.networking.hostName};
  wireguardPeers = pkgs.lib.mapAttrsToList (_: value: value) (
    removeAttrs wgHostInfo [config.networking.hostName]
  );
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
    gossipSecretFile = {
      sopsFile = ./secrets.yaml;
    };
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
      };
    };
  };
}
