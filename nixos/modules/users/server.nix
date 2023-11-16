{
  config,
  userName ? "server",
  ...
}: {
  imports = [./.];

  users.users = {
    ${userName} = {
      isNormalUser = true;
      home = "/home/${userName}";
      extraGroups = ["wheel" "k3s"];
    };
  };

  home-manager.users.${userName}.imports = [
    ../../../home/profiles/server.nix
  ];
}
