{config, ...}: {
  imports = [
    ./.
  ];

  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["audio" "docker" "wheel" "networkmanager" config.users.groups.keys.name];
    };
  };

  home-manager.users.schwem = import ../../../home/profiles/pc-gui.nix;
}
