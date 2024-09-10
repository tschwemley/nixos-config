{ config, ... }:
{
  imports = [ ./config.nix ];

  services.nginx.virtualHosts."sabnzbd.schwem.io" = {
    locations = {
      "/" = {
        proxyPass = "127.0.0.1:${config.portMap.sabnzbd}";
      };
    };
  };

  services.sabnzbd = {
    enable = true;
    configFile = config.sops.templates."sabnzbd.ini".path;
  };

  systemd.tmpfiles.rules = [
    "d /storage/downloads 0660 sabznbd sabnzbd - -"
  ];
}
