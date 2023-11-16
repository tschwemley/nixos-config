{
  networking.firewall.allowedUDPPorts = [51820];
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.1.1.1.2/24"];
      listenPort = 51820;
      privateKeyFile = "/persist/wireguard/private";

      peers = [
        {
          publicKey = "DXGnAkpq/sM4Dw6vl26gmdggE8ItGi9H/61GQ8nWR14=";

          # Forward all the traffic via VPN.
          allowedIPs = ["0.0.0.0/0"];
          # Or forward only particular subnets
          #allowedIPs = [ "10.1.1.1.1" "91.108.12.0/22" ];

          endpoint = "wg.schwem.io:51820";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
