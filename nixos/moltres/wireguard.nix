let
  publicKey = "1YcCJFA6eAskLk0/XpBYwdqbBdHgNRaW06ZdkJs8e1s=";
in {
  networking.firewall.allowedUDPPorts = [51820];
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.1.1.2/24"];
      listenPort = 51820;
      privateKeyFile = "/persist/wireguard/private";

      # use postUp instead of persistentKeepalive because persistentKeepalive doesn't auto-connect
      # to the peer. This is apparently because the private key is set after the persistentKeepalive
      # which happens because we're setting the private key from a file.
      # postSetUp = ["wg set wgnet0 peer ${publicKey} persistent-keepalive 25"];
      postSetUp = ["wg set wg0 peer ${publicKey} persistent-keepalive 25"];
      peers = [
        {
          inherit publicKey;

          # Forward all the traffic via VPN.
          allowedIPs = ["0.0.0.0/0"];

          endpoint = "wg.schwem.io:51820";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          # persistentKeepalive = 25;
        }
      ];
    };
  };
}
