{
  config,
  lib,
  ...
}: {
  options.ethDev = with lib;
    mkOption {
      type = types.str;
      default = "ens3";
      description = "The ethernet device to use for the primary network.";
    };

  config = {
    networking = {
      dhcpcd.enable = false;
      useDHCP = lib.mkDefault false;
      useNetworkd = true;
    };

    systemd.network = {
      enable = true;
      wait-online.enable = lib.mkDefault false; # TODO: fix this?
    };

    sops = {
      secrets = {
        publicIP = {};
        gateway = {};
      };

      templates."10-primary.network" = {
        inherit (config.users.users.systemd-network) group;
        owner = config.users.users.systemd-network.name;

        mode = "0444";
        path = "/etc/systemd/network/10-primary.network";

        content = ''
          [Match]
          Name=${config.ethDev}

          [Network]
          Address=${config.sops.placeholder.publicIP}/24
          DNS=194.242.2.2 2a07:e340::2

          [Route]
          Destination=0.0.0.0/0
          Gateway=${config.sops.placeholder.gateway}
        '';
      };
    };
  };
}
