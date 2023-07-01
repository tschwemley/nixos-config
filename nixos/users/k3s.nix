{
  imports = [./.];

  users.users = {
    k3s = {
      isNormalUser = true;
      home = "/home/k3s";
      extraGroups = ["wheel" "k3s"];
      # openssh.authorizedKeys.keys = keys;
    };
  };

  home-manager.users.k3s.imports = [
    ../../home/profiles/server.nix
  ];
}
