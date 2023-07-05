{config, userName ? "server" ...}:
{
  imports = [./.];

  users.${userName} = {
    server = {
      isNormalUser = true;
      home = "/home/${userName}";
      extraGroups = ["wheel" "k3s"];
    };
  };

  home-manager.users.server.imports = [
    ../../../home/profiles/server.nix
  ];
}
