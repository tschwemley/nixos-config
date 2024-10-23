{ config, ... }:
{
  imports = [ ./config.nix ];

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
      "f /var/lib/sabnzbd/scripts/move-dls 0750 sabnzbd sabnzbd - ${builtins.readFile ./post-process}"
    ];
  };

  users.users.sabnzbd.extraGroups = [ "arr" ];
}
