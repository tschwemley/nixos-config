{
  self,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.anki-sync-server];
  services = {
    anki-sync-server = {
      enable = true;

      users = [
        {
          username = "schwem";
          passwordFile = "/run/secrets/anki_schwem_password";
        }
      ];
    };
  };

  sops.secrets."anki_schwem_password" = {
    mode = "0400";
    sopsFile = self.lib.secret "server" "anki.yaml";
  };
}
