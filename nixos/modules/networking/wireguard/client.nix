{
  pkgs,
  ipWithSubnet,
  port ? 51820,
  privateKeyFile ? "/persist/wireguard/private",
  serverIp,
  serverPublicKey,
  ...
}: {
  imports = [./.];

  networking.wireguard.interfaces = {
    wg0 = {
      peers = [
        # For a client configuration, one peer entry for the server will suffice.
        {
          # Set this to the server IP and port.
          endpoint = "${serverIP}:${port}";

          publicKey = serverPublicKey;

          # Forward all the traffic via VPN.
          allowedIPs = ["0.0.0.0/0"];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
