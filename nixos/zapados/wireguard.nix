{config, ...}: {
  networking.firewall.allowedUDPPorts = [51820];
  networking.firewall.enable = true;
  # this gives networkd appropriate perms to read the secret
  systemd.services.systemd-networkd.serviceConfig.SupplementaryGroups = [config.users.groups.keys.name];
  systemd.network = {
    enable = true;
    netdevs = {
      "20-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1430";
        };
        # See also man systemd.netdev (also contains info on the permissions of the key files)
        wireguardConfig = {
          PrivateKeyFile = "/persist/wireguard/private";
          ListenPort = 51820;
        };
        wireguardPeers = [
          {
            wireguardPeerConfig = {
              PublicKey = "6xPGijlkm3yDDLEy1vAWilcnvUcKxODy7oXT7YCwJj4=";
              AllowedIPs = ["10.0.0.2/32"];
            };
          }
        ];
      };
    };
    networks.wg0 = {
      # See also man systemd.network
      matchConfig.Name = "wg0";
      address = [
        "10.0.0.1/24"
      ];
      DHCP = "yes";
      # dns = [ "" ];
      # gateway = [
      # "10.0.0.1"
      # ];
    };
  };
}
