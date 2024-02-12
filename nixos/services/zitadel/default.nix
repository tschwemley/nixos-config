{config, ...}: rec {
  imports = [./virtualhost.nix];

  services.zitadel = {
    enable = true;
    masterKeyFile = config.sops.secrets.masterKey.path;
  };

  sops.secrets.masterKey = {
    sopsFile = ./secrets.yaml;
    owner = services.zitadel.user;
    group = services.zitadel.group;
  };
}
