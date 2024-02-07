{
  # self,
  config,
  pkgs,
  ...
}: let
  # charizard = {
  #   address = "10.0.0.xx";
  #   pubkey = "";
  # };
  wgHostInfo = {
    articuno = {
      address = "10.0.0.1";
      endpoint = "articuno.schwem.io";
      pubkey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
    };
    zapados = {
      address = "10.0.0.2";
      pubkey = "Q1+mLYcJfyU6CtlMxJbAYdBck2v/9VMGBu/33+opokU=";
    };
    moltres = {
      address = "10.0.0.3";
      endpoint = "moltres.schwem.io";
      pubkey = "reQIKAlaJvkqkASpM0xxntIcoB8S5ImXw500m1sRs0Q=";
    };
    eevee = {
      address = "10.0.0.4";
      pubkey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
    };
    flareon = {
      address = "10.0.0.5";
      pubkey = "3g+cRzwGUcm+0N/WQlPgBYDcq/IQaA/N2UqMyNn1QWw=";
    };
    jolteon = {
      address = "10.0.0.6";
      pubkey = "";
    };
  };

  host = wgHostInfo.${config.networking.hostName};
in {
  networking = {
    useDHCP = false;

    firewall = {
      allowedTCPPorts = [51820];
      trustedInterfaces = ["wg0"];
    };

    wireguard.interfaces.wg0 = {
      ips = ["${host.address}/24"];
    };
  };

  services.wgautomesh = {
    enable = true;
    gossipSecretFile = config.sops.secrets.gossipSecretFile.path;
    settings = {
      interface = "wg0";
      peers = pkgs.lib.mapAttrsToList (_: value: value) (
        removeAttrs wgHostInfo [config.networking.hostName]
      );
    };
  };

  sops.secrets.gossipSecretFile = {
    sopsFile = ./secrets.yaml;
  };

  # environment.systemPackages = with pkgs; [
  #   wireguard-tools
  # ];
  #
  # networking.firewall.allowedUDPPorts = [listenPort];
  #
  # sops = {
  #   secrets = {
  #     wireguard_private = {
  #       mode = "0400";
  #       path = "/persist/secrets/wireguard-private";
  #       owner = config.users.users.systemd-network.name;
  #       group = config.users.users.systemd-network.group;
  #       restartUnits = ["systemd-networkd" "systemd-resolved"];
  #     };
  #   };
  # };
  #
  # # this gives networkd appropriate perms to read the secret
  # systemd.services.networkd.serviceConfig.SupplementaryGroups = [config.users.groups.keys.name];
  #
  # systemd.network = {
  #   netdevs = {
  #     "20-wg0" = {
  #       inherit wireguardPeers;
  #       netdevConfig = {
  #         Kind = "wireguard";
  #         Name = "wg0";
  #         MTUBytes = "1430";
  #       };
  #       # See also man systemd.netdev (also contains info on the permissions of the key files)
  #       wireguardConfig = {
  #         PrivateKeyFile = "/persist/wireguard/private";
  #         ListenPort = listenPort;
  #       };
  #     };
  #   };
  #   networks = {
  #     "20-wg0" = {
  #       # inherit gateway;
  #       matchConfig.Name = "wg0";
  #       # IP addresses the client interface will have
  #       address = [
  #         "${ip}/24"
  #       ];
  #     };
  #   };
  # };
}
