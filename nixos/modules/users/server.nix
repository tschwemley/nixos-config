{
  config,
  userName ? "server",
  userSSHKey ? "",
  ...
}: {
  imports = [./.];

  users.users = {
    ${userName} = {
      isNormalUser = true;
      home = "/home/${userName}";
      extraGroups = ["wheel" "k3s"];
      openssh.authorizedKeys.keys = [userSSHKey];
    };
  };

  home-manager.users.${userName}.imports = [
    ../../../home/profiles/server.nix
  ];
}
