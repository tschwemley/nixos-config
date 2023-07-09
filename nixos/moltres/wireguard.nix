let
	publicKey = "DXGnAkpq/sM4Dw6vl26gmdggE8ItGi9H/61GQ8nWR14=";
in
{
  networking.firewall.allowedUDPPorts = [51820];
  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.1.1.2/24"];
      listenPort = 51820;
      privateKeyFile = "/persist/wireguard/private";

	  # use postUp instead of persistentKeepalive because persistentKeepalive doesn't auto-connect
	  # to the peer. This is apparently because the private key is set after the persistentKeepalive
	  # which happens because we're setting the private key from a file.
	  postUp = ["wg set wgnet0 peer ${publicKey} persistent-keepalive 25"];
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
