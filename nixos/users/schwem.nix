{homeConfigurations, lib, ...}: {
  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      openssh.authorizedKeys.keys = [builtins.readFile ../../secrets/keys/charizard.pub];
    };
  };

  home-manager.users.schwem = {
	  inherit (homeConfigurations) schwem;
  };

  # home-manager.users.schwem = homeConfigurations.schwem;
  # home-manager.users.schwem = {
  #   imports = [
  #    (homeConfigurations.pc
  #     {
  #       home.username = "schwem";
  #       home.homeDirectory = "/home/schwem";
  #     })
  #   ];
  # };
}
