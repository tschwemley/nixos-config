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
      extraUpFlags = [ "--ssh" ];
      openFirewall = true;
      useRoutingFeatures = "both"; # sets reverse path 'loose' + ip forwarding
    };

    sops.secrets.tailscale_auth_key = { };

    systemd.services.tailscaled-autoconnect.after = lib.mkDefault [
      "systemd-networkd"
      "tailscaled.service"
    ];
  };
}
