{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages = with pkgs; [ ethtool ];
    networking.firewall.trustedInterfaces = [ "tailscale0" ];

    services.tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale_auth_key.path;
      openFirewall = true;
      useRoutingFeatures = "both"; # sets reverse path 'loose' + ip forwarding
      extraUpFlags = [ "--ssh" ];
    };

    sops.secrets.tailscale_auth_key = { };

    systemd.services.tailscaled-autoconnect.after = lib.mkDefault [
      "systemd-networkd"
      "tailscaled.service"
    ];
  };
}
