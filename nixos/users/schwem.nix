{homeConfigurations, ...}: {
  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      openssh.authorizedKeys.keys = [builtins.readFile ../../secrets/keys/charizard.pub];
    };
  };

  home-manager.users.schwem.imports = [
	../../home/profiles/pc.nix
  ];
}
