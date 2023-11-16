{config, ...}:
{
  imports = [./.];

  users.users = {
    server = {
      isNormalUser = true;
      home = "/home/k3s";
      extraGroups = ["wheel" "k3s"];
      # openssh.authorizedKeys.keys = keys;
    };
  };

  home-manager.users.server.imports = [
    ../../../home/profiles/server.nix
  ];
}
