{
  lib,
  pkgs,
  ...
}: {
  imports = [./wireshark.nix];

  environment.systemPackages = [pkgs.traceroute];

  networking = {
    firewall = {
      enable = true;
      allowPing = true;
    };

    nameservers = ["194.242.2.2" "2a07:e340::2"];

    nftables.enable = true;
  };

  # always use systemd-resolved
  services.resolved = {
    enable = true;
    dnssec = lib.mkDefault "false";
    dnsovertls = "opportunistic";
    domains = ["~."];
    fallbackDns = ["194.242.2.2" "2a07:e340::2"];
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
