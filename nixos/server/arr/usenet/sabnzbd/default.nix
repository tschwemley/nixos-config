{config, ...}: {
  imports = [./config.nix];

  services = {
    prometheus.exporters.sabnzbd.enable = true;

    sabnzbd = {
      enable = true;
      configFile = config.sops.templates."sabnzbd.ini".path;
    };
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
        "d /storage/downloads/complete 0770 sabznbd arr - -"
        "d /storage/downloads/incomplete 0770 sabznbd arr - -"

        "d /var/lib/sabnzbd 0760 sabznbd sabnzbd - -"
        "C+ /var/lib/sabnzbd/scripts/post-process 0755 sabnzbd sabnzbd - ${./post-process}"
      ];
    };
  };

  users.users.sabnzbd.extraGroups = ["arr"];
}
