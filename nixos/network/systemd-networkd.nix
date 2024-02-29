{config, ...}: {
  systemd.network.enable = true;
  sops.secrets = {
    publicIP = {};
    gateway = {};
  };

  sops.templates."10-primary.network" = {
    group = config.users.users.systemd-network.group;
    owner = config.users.users.systemd-network.name;

    mode = "0444";
    path = "/etc/systemd/network/10-primary.network";

    content = ''
      [Match]
      Name=ens3

      [Network]
      Address=${config.sops.placeholder.publicIP}/24
      DNS=1.1.1.1 1.0.0.1

      [Route]
      Destination=0.0.0.0/0
      Gateway=${config.sops.placeholder.gateway}
    '';
  };
}
