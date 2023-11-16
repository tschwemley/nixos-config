{
  config,
  homeConfigurations,
  ...
}: let
  # defaultSopsFile = config.sops.defaultSopsFile;
in {
  imports = [
    ./.
  ];

  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" config.users.groups.keys.name];
    };
  };

  home-manager.users.schwem = {
    imports = [
      # homeConfigurations.schwem.activation-script
      ../../../home/profiles/pc.nix
    ];
  };
}
