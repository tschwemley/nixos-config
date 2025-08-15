{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.traceroute ];

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
    dnssec = "true";
    dnsovertls = "opportunistic";
    domains = [ "~." ];
    fallbackDns = [ "9.9.9.9" ];
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
