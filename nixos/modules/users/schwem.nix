{config, homeConfigurations, ...}: {
  imports = [./.];

  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" config.users.groups.keys.name];
    };
  };

  home-manager.users.schwem.imports = [
    ../../../home/profiles/pc.nix
  ];
}
