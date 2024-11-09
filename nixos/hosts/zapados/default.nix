{
  config,
  secretsPath,
  ...
}: {
  imports = [
    ../../profiles/proxmox.nix

    # server imports
    ../../../containers/it-tools

    ../../server/alt-frontends/binternet.nix
    ../../server/alt-frontends/priviblur
    ../../server/alt-frontends/safetwitch
    ../../server/automation/home-assistant
    ../../server/knowledge/tiddlywiki.nix
  ];

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";

  # TODO: if keeping then move over to server dir
  services.oauth2-proxy = {
    enable = true;
    email.domains = ["schwem.io" "gmail.com"];
    keyFile = config.sops.secrets."oauth2-proxy.env".path;
  };

  sops.secrets."oauth2-proxy.env" = {
    # path = "${secretsPath}/secrets/server/oauth2-proxy.env";
    sopsFile = "${secretsPath}/server/oauth2-proxy.yaml";
  };
}
