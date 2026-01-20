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

    services = {
      # Optimizes the performance of subnet routers and exit nodes
      networkd-dispatcher = {
        enable = true;
        rules."50-tailscale" = {
          onState = [ "routable" ];
          script = ''
            ${lib.getExe pkgs.ethtool} -K eth0 rx-udp-gro-forwarding on rx-gro-list off
          '';
        };
      };

      tailscale = {
        enable = true;

        authKeyFile = config.sops.secrets.tailscale_auth_key.path;
        disableTaildrop = true;
        extraUpFlags = [ "--ssh" ];
        openFirewall = true;
        useRoutingFeatures = "both"; # sets reverse path 'loose' + ip forwarding
      };
    };

    sops.secrets.tailscale_auth_key = { };

    systemd.services.tailscaled.before = lib.mkDefault [
      "mnt-jolteon-storage.mount"
      "mnt-flareon-storage.mount"
      "mnt-flareon-storage2.mount"
      "mnt-flareon-storage3.mount"
      "mnt-flareon-storage4.mount"
      "mnt-tentacool-storage.mount"
    ];
  };
}
