{homeConfigurations, lib, ...}: {
  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      openssh.authorizedKeys.keys = [builtins.readFile ../../secrets/keys/charizard.pub];
    };
  };

  home-manager.users.schwem = homeConfigurations.schwem;
}
