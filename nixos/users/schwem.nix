{homeConfigurations, ...}: {
  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      # openssh.authorizedKeys.keys = keys;
    };
  };

  home.stateVersion = "23.05";
  home-manager.users.schwem = (import ../../home/profiles/pc.nix {});
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
