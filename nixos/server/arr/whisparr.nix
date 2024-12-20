{
  config,
  secretsPath,
  ...
}: {
  # TODO: remove this and the whisparr service when merged into unstable (as of writing in master)
  imports = [./whisparr-service.nix];

  services.whisparr.enable = true;
  sops.secrets."whisparr_config.xml" = let
    inherit (config) users;
  in {
    group = users.groups.whisparr.name;
    owner = users.users.whisparr.name;
    path = "${users.users.whisparr.home}/config.xml";
    sopsFile = "${secretsPath}/server/arr.yaml";
  };
}
