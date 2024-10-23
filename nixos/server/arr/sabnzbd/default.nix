{ config, ... }:
{
  imports = [ ./config.nix ];

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8314 ];

  services.sabnzbd = {
    enable = true;
    configFile = config.sops.templates."sabnzbd.ini".path;
  };

  systemd = {
    services.sabznbd = {
      after = [
        "storage.mount"
        "tailscaled.service"
      ];
      wants = [
        "storage.mount"
        "tailscaled.service"
      ];
    };

    tmpfiles.rules = [
      "d /storage/downloads 0660 sabznbd arr - -"
    ];
  };

  users.users.sabnzbd.extraGroups = [ "arr" ];
}
