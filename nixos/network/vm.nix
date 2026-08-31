{ self, ... }:
{
  imports = [
    self.inputs.nixtornet.nixosModules.default
  ];

  # The module automatically configures Tor with sensible defaults
  # You can customize Tor settings via services.tor.settings
  services.tor.settings = {
    # Optional: customize Tor configuration
    # The module sets required values for transparent proxying
  };

  networking.firewall.enable = true; # Required for transparent proxying

  services.nixtornet = {
    enable = true;

    tor = {
      enable = true;
      networks = [ "tor-vm" ];
    };

    networks = {
      tor-vm = {
        name = "tor-vm";
        uuid = "12345678-1234-1234-1234-123456789abc";
        bridge.name = "virbr-tor";
        ip = {
          address = "192.168.100.1";
          netmask = "255.255.255.0";
          dhcp = {
            range = {
              start = "192.168.100.2";
              end = "192.168.100.254";
            };
          };
        };
      };
    };
  };
}
