{
  config,
  lib,
  ...
}: {
  options.tailscaleUpFlags = with lib;
    mkOption {
      type = types.listOf types.str;
      default = [];
      description = "The ethernet device to use for the primary network.";
    };

  config = {
    networking.firewall.trustedInterfaces = ["tailscale0"];

    services.tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets.tailscale_auth_key.path;
      openFirewall = true;
      # extraUpFlags = ["--ssh"] ++ config.tailscaleUpFlags;
      extraUpFlags = ["--ssh"];
      useRoutingFeatures = "both"; # sets reverse path 'loose' + ip forwarding
    };

    sops.secrets.tailscale_auth_key = {};

    systemd.services.tailscaled-autoconnect.after = lib.mkDefault ["systemd-networkd" "tailscaled.service"];
  };
}
