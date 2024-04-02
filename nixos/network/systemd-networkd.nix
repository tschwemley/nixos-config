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
      useDHCP = false;
      useNetworkd = true;
    };

    systemd.network = {
      enable = true;
      wait-online.enable = false; # TODO: fix this?
    };

    sops = {
      secrets = {
        publicIP = {};
        gateway = {};
      };

      templates."10-primary.network" = {
        group = config.users.users.systemd-network.group;
        owner = config.users.users.systemd-network.name;

        mode = "0444";
        path = "/etc/systemd/network/10-primary.network";

        content = ''
          [Match]
          Name=${config.ethDev}

          [Network]
          Address=${config.sops.placeholder.publicIP}/24
          #DNS=194.242.2.2
          DNS=1.1.1.1 1.0.0.1

          [Route]
          Destination=0.0.0.0/0
          Gateway=${config.sops.placeholder.gateway}
        '';
      };
    };
  };
}
