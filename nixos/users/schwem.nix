{
  users.users = {
    schwem = {
      isNormalUser = true;
      home = "/home/schwem";
      extraGroups = ["wheel" "networkmanager"];
      # openssh.authorizedKeys.keys = keys;
    };
  };

  home-manager.users.schwem = import ../../../home-manager/profiles/desktop.nix;
}
