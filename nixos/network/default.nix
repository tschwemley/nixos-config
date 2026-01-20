{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    traceroute
    unixtools.net-tools
  ];

  networking = {
    firewall = {
      enable = true;
      allowPing = true;
    };

    nftables.enable = true;
  };

  # always use systemd-resolved
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "true";
      DNSOverTLS = "opportunistic";
      Domains = [ "~." ];
      FallbackDNS = [ "9.9.9.9" ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      #GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };
}
