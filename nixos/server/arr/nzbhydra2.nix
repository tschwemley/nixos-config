{
  pkgs,
  secretsPath,
  ...
}: {
  services.nzbhydra2 = {
    enable = true;
    package = pkgs.nzbhydra2.overrideAttrs rec {
      version = "7.10.1";
      src = pkgs.fetchzip {
        url = "https://github.com/theotherp/nzbhydra2/releases/download/v${version}/nzbhydra2-${version}-generic.zip";
        hash = "sha256-Nnrh8gvdxqDfANEeBX9/Q0DiRGuF0qJsGnH86g3/3O4=";
        stripRoot = false;
      };
    };
  };

  systemd.services.nzbhydra2 = {
    environment.SOPS_AGE_KEY_FILE = "/etc/sops/age-keys.txt";
    preStart = ''
      ${pkgs.sops}/bin/sops -d ${secretsPath}/server/nzbhydra.yaml > /var/lib/nzbhydra2/nzbhydra.yml
    '';

    serviceConfig.ReadPaths = ["/etc/sops/age-keys.txt"];
  };
}
