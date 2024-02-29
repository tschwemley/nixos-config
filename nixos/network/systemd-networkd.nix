{config, ...}: {
  systemd.network.enable = true;
  sops.secrets = {
    publicIP = {};
    gateway = {};
  };

  sops.templates."10-primary" = {
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
    owner = config.users.users.systemd-network.name;
    group = config.users.users.systemd-network.group;
    path = "/etc/systemd/network/10-primary";
  };
}
