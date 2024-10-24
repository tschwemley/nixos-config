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

    tmpfiles = {
      rules = [
        "d /storage/downloads 0660 sabznbd arr - -"
        "d /var/lib/sabnzbd 0760 sabznbd sabnzbd - -"
        "C+ /var/lib/sabnzbd/scripts/post-process 0755 sabnzbd sabnzbd - ${./post-process}"
      ];
    };
  };

  users.users.sabnzbd.extraGroups = [ "arr" ];
}
