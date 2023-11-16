{homeConfigurations, ...}: {
  users.users = {
    schwem = {
      isNormalUser = true;
      home = "/home/schwem";
      extraGroups = ["wheel" "networkmanager"];
      # openssh.authorizedKeys.keys = keys;
    };
  };

  home-manager.users.schwem = {
    imports = [
     (homeConfigurations.pc
      {
        home.username = "schwem";
        home.homeDirectory = "/home/schwem";
      })
    ];
  };
}
