{
  config,
  ip,
  peers,
  pkgs,
  listenPort ? 9918,
  ...
}: let
  wireguardPeers = builtins.map (peer: {wireguardPeerConfig = peer;}) peers;
in {
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedUDPPorts = [listenPort];

  sops = {
    secrets = {
      wireguard_private = {
        mode = "0400";
        path = "/persist/wireguard/private";
        owner = config.users.users.systemd-network.name;
        group = config.users.users.systemd-network.group;
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  # this gives networkd appropriate perms to read the secret
  systemd.services.networkd.serviceConfig.SupplementaryGroups = [config.users.groups.keys.name];

  systemd.network = {
    netdevs = {
      "20-wg0" = {
        inherit wireguardPeers;
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1430";
        };
        # See also man systemd.netdev (also contains info on the permissions of the key files)
        wireguardConfig = {
          PrivateKeyFile = "/persist/wireguard/private";
          ListenPort = listenPort;
        };
      };
    };
    networks = {
      "20-wg0" = {
        # inherit gateway;
        matchConfig.Name = "wg0";
        # IP addresses the client interface will have
        address = [
          "${ip}/24"
        ];
      };
    };
  };
}
