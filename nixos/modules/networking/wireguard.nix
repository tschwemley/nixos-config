{
  config,
  ip,
  peers,
  endpoint ? "",
  gateway ? ["10.0.0.1"],
  listenPort ? 9918,
  ...
}: let
  wireguardPeers = builtins.map (peer: {wireguardPeerConfig = peer;}) peers;
in {
  networking.firewall.enable = true;
  networking.firewall.allowedUDPPorts = [listenPort];

  # this gives networkd appropriate perms to read the secret
  systemd.services.networkd.serviceConfig.SupplementaryGroups = [config.users.groups.keys.name];

  systemd.network = {
    netdevs = {
      "20-wg0" = {
        inherit wireguardPeers;
        netdevConfig = {
          PersistentKeepalive = "25";
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
