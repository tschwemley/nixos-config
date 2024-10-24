{ config, secretsPath, ... }:
{
  services = {
    # TODO: uncomment if exposing via web; otherwise delete
    # nginx.virtualHosts."nzbhydra.schwem.io".locations = {
    #   "/" = {
    #     proxyPass = "http://127.0.0.1:${config.portMap.nzbhydra2}";
    #   };
    # };

    nzbhydra2.enable = true;
  };

  systemd.services.nzbhydra2.preStart = ''
    sops --config '/etc/sops/age-keys.txt' -d ${secretsPath}/server/nzbhydra.yaml
  '';

  # sops.secrets."nzbhydra.yaml" = {
  #   group = config.systemd.services.nzbhydra2.serviceConfig.Group;
  #   owner = config.systemd.services.nzbhydra2.serviceConfig.User;
  #   mode = "0600";
  #   path = "/var/lib/nzbhydra2/nzbhydra.yml";
  #   sopsFile = "${secretsPath}/nzbhydra.yaml";
  #   format = "binary";
  # };
}
