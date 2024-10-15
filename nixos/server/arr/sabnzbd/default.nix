{ config, ... }:
{
  imports = [ ./config.nix ];

  # TODO: remove or keep -- for now leaning towards only allowing this to be accessible internally
  # services.nginx.virtualHosts."sabnzbd.schwem.io" = {
  #   locations = {
  #     "/" = {
  #       proxyPass = "http://127.0.0.1:${config.portMap.sabnzbd}";
  #     };
  #   };
  # };

  services.sabnzbd = {
    enable = true;
    configFile = config.sops.templates."sabnzbd_ini".path;
  };

  systemd.tmpfiles.rules = [
    "d /storage/downloads 0660 sabznbd sabnzbd - -"
  ];
}
