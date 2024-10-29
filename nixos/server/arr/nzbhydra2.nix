{
  pkgs,
  secretsPath,
  ...
}: {
  services = {
    # TODO: uncomment if exposing via web; otherwise delete
    # nginx.virtualHosts."nzbhydra.schwem.io".locations = {
    #   "/" = {
    #     proxyPass = "http://127.0.0.1:${config.portMap.nzbhydra2}";
    #   };
    # };

    nzbhydra2.enable = true;
  };

  systemd.services.nzbhydra2 = {
    environment.SOPS_AGE_KEY_FILE = "/etc/sops/age-keys.txt";
    preStart = ''
      ${pkgs.sops}/bin/sops -d ${secretsPath}/server/nzbhydra.yaml > /var/lib/nzbhydra2/nzbhydra.yml
    '';

    serviceConfig.ReadPaths = ["/etc/sops/age-keys.txt"];
  };
}
