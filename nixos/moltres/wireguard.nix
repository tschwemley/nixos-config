{
  networking.firewall.allowedUDPPorts = [51820];
  boot.extraModulePackages = [config.boot.kernelPackages.wireguard];
  systemd.network = {
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
          ListenPort = 9918;
        };
        wireguardPeers = [
          {
            wireguardPeerConfig = {
              PublicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
              AllowedIPs = ["10.0.0.1/32"];
              Endpoint = "wg.schwem.io:51820";
            };
          }
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      # IP addresses the client interface will have
      address = [
        "10.0.0.2/24"
      ];
    };
  };
}
